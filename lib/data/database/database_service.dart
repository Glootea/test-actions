import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queue/data/database/providers/local_database.dart';
import 'package:queue/data/database/providers/online_database.dart';
import 'package:queue/entities/export.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:queue/extension.dart';

class DataBaseService {
  OnlineDataBase? _onlineDataBase;
  final LocalDatabase _localDatabase;
  GoogleSignIn? _googleSignIn;

  DataBaseService._(this._localDatabase, this._onlineDataBase);

  LocalDatabase get localDatabase => _localDatabase;
  OnlineDataBase get onlineDataBase {
    assert(_onlineDataBase != null, "OnlineDataBase has not been initialized in DataBaseService");
    return _onlineDataBase!;
  }

  static DataBaseService? _instance;

  static Future<DataBaseService> instance({String? tableID}) async {
    if (_instance != null && tableID == null) {
      return _instance!;
    }
    final LocalDatabase localDatabase = LocalDatabase();
    tableID ??= await localDatabase.get(StoredValues.infoTableID);
    if (tableID == null) {
      _instance ??= await Future.value(DataBaseService._(localDatabase, null));
      return _instance!;
    }
    final OnlineDataBase onlineDataBase = await OnlineDataBase.instance(tableID: tableID);
    _instance ??= await Future.value(DataBaseService._(localDatabase, onlineDataBase));
    return _instance!;
  }

  Future<void> createRec(String lessonName, String studentName, DateTime time) async {
    final [rowNumber as int, String tableID as String] =
        (await Future.wait([_localDatabase.getOnlineTableRowNumber(studentName), _localDatabase.getLessonTableID(lessonName)])).toList();
    final task1 = _localDatabase.createRec(lessonName, studentName, time);
    final task2 = _onlineDataBase?.createRec(tableID, rowNumber, time) ?? Future.value(false);
    final result = await Future.wait([task1, task2]);
    if (result[1] == true) {
      await _localDatabase.updateUploadStatus(lessonName, studentName, true);
    }
  }

  Future<void> deleteRec(String lessonName, String studentName) async {
    final [rowNumber as int, String tableID as String] =
        (await Future.wait([_localDatabase.getOnlineTableRowNumber(studentName), _localDatabase.getLessonTableID(lessonName)])).toList();
    final task1 = _localDatabase.deleteRec(lessonName, studentName);
    final task2 = _onlineDataBase?.deleteRec(tableID, rowNumber) ?? Future.value(false);
    final _ = await Future.wait([task1, task2]);
  }

  Future<List<LessonEntity>> todayLessons(DateTime today, String studentName) {
    return _localDatabase.todayLessons(today, studentName);
  }

  Future<String?> get(StoredValues key) {
    return _localDatabase.get(key);
  }

  Future<int> set(StoredValues key, String value) async {
    return _localDatabase.set(key, value);
  }

  Future<int> clean(StoredValues key) async {
    return _localDatabase.clean(key);
  }

  Future<GoogleSignInAccount?> signInGoogle() async {
    _googleSignIn = GoogleSignIn(
      clientId: "842227545035-m0m949sgn56qkfqsgscb5lgrdpoog82l.apps.googleusercontent.com",
      scopes: [
        'https://www.googleapis.com/auth/drive.file',
      ],
    );
    await _googleSignIn!.signOut();
    final user = await _googleSignIn!.signIn();
    return user;
  }

  Future<void> registerGroup(List<LessonSettingEntity> lessons, List<StudentEntity> students, String headManName, String groupName) async {
    if (_googleSignIn?.currentUser == null) {
      await signInGoogle();
    }
    if (_googleSignIn == null) {
      throw Exception("Google sign in not initialized");
    }
    final httpClient = (await _googleSignIn?.authenticatedClient())!;
    final driveApi = DriveApi(httpClient);
    final folder = await driveApi.files.create(File(mimeType: 'application/vnd.google-apps.folder', name: "Student Queue"));
    final infoFileID = await _createSpreadSheetFileOnDrive(folder.id!, "info", driveApi);
    // TODO: autorize user fully
    await set(StoredValues.infoTableID, infoFileID);
    _onlineDataBase = await OnlineDataBase.instance(tableID: infoFileID);
    List<Future<String>> lessonCreation = [];
    for (final lesson in lessons) {
      lessonCreation.add(Future.value(_createSpreadSheetFileOnDrive(folder.id!, lesson.name, driveApi).then((value) {
        _onlineDataBase!.createFrameOfQueueTable(value);
        return value;
      })));
    }
    final lessonIds = await Future.wait(lessonCreation);
    await Future.wait([insertLessons(lessons, lessonIds), insertStudents(students), _onlineDataBase!.fillGroupInfo(headManName, groupName)]);
  }

  Future<String> _createSpreadSheetFileOnDrive(String folderId, String name, DriveApi driveApi) async {
    final infoFile = File(
      parents: [folderId],
      mimeType: "application/vnd.google-apps.spreadsheet",
      name: name,
    );
    final permisson = Permission(role: "writer", type: "user", emailAddress: "queue-410@queue-401413.iam.gserviceaccount.com");
    final onlineFile = await driveApi.files.create(infoFile);
    await driveApi.permissions.create(permisson, onlineFile.id!);
    return onlineFile.id!;
  }

  void import(List<RecEntity> list) {} //TODO: implement

  Future<void> insertLessons(List<LessonSettingEntity> lessons, List<String> lessonIds) async {
    if (_onlineDataBase == null) {
      throw Exception("Online database not initialized");
    }
    Future.wait([_localDatabase.insertLessons(lessons, lessonIds), _onlineDataBase!.fillLessons(lessons, lessonIds)]);
  }

  Future<void> insertStudents(List<StudentEntity> students) async {
    if (_onlineDataBase == null) {
      throw Exception("Online database not initialized");
    }
    await _onlineDataBase!.fillStudents(students);
    students = await _onlineDataBase!.getStudents();
    await _localDatabase.insertStudents(students);
  }

  /// Provide headman's [GoogleSignInAccount] to fetch data from their Google Drive, otherwise data will be fetched from local database
  Future<void> fetchDataFromDrive({GoogleSignInAccount? account}) async {
    String? infoTableID = (account != null) ? await _findInfoTableOnDrive() : await get(StoredValues.infoTableID);
    if (infoTableID == null) {
      throw Exception("Info table not found");
    }
    _onlineDataBase = await OnlineDataBase.instance(tableID: infoTableID);
    final result = await Future.wait([_onlineDataBase!.getStudents(), _onlineDataBase!.getHeadName()]);
    final students = result[0] as List<StudentEntity>;
    final headManName = result[1] as String;
    final _ = await Future.wait([_localDatabase.insertStudents(students), _localDatabase.set(StoredValues.userName, headManName)]);
    final (lessons, ids) = await _onlineDataBase!.getLessons();
    final result2 = await Future.wait([lessons, ids]);
    await _localDatabase.insertLessons(result2[0] as List<LessonSettingEntity>, result2[1] as List<String>);
  }

  Future<String?> _findInfoTableOnDrive() async {
    if (_googleSignIn?.currentUser == null) {
      await signInGoogle();
    }
    if (_googleSignIn == null) {
      throw Exception("Google sign in not initialized");
    }
    final httpClient = (await _googleSignIn?.authenticatedClient())!;
    final driveApi = DriveApi(httpClient);
    final fileList = await driveApi.files.list(q: "mimeType = 'application/vnd.google-apps.folder' and trashed = false and name = 'Student Queue'");
    final count = fileList.files!.length;
    if (_checkFileCount(count)) {
      final folderID = fileList.files!.first.id!;
      final ssFileList =
          await driveApi.files.list(q: "mimeType = 'application/vnd.google-apps.spreadsheet' and trashed = false and parents = '$folderID' and name = 'info'");
      final ssCount = ssFileList.files!.length;
      if (_checkFileCount(ssCount)) {
        return ssFileList.files!.first.id!;
      }
    }
    return null;
  }

  bool _checkFileCount(int count) {
    if (count == 0) {
      throw MultipleFilesOnDiskException("Папка с данными не найдена. Создайте новую группу");
    } else if (count > 1) {
      throw NoFileFoundOnDiskException("Найдено более одного файла. Удалите неактуальные папки и файлы с названием 'Student Queue'");
    }
    return true;
  }

  getData() {}

  Future<bool> postNotUploadedRecs(String studentName) async {
    final list = await _localDatabase.getNotUploadedRecs(studentName);
    if (list.isEmpty) {
      return false;
    }
    List<Future> tasks = [];
    for (final rec in list) {
      final [rowNumber as int, String tableID as String] =
          (await Future.wait([_localDatabase.getOnlineTableRowNumber(studentName), _localDatabase.getLessonTableID(rec.lessonName)])).toList();
      tasks.add(_onlineDataBase?.createRec(tableID, rowNumber, rec.time).then((value) async {
            if (value) await _localDatabase.updateUploadStatus(rec.lessonName, studentName, true);
          }) ??
          Future.value(false));
    }
    await Future.wait(tasks);
    return true;
  }
}
