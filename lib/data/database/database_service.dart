import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/entities/export.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:queue/extension.dart';

class DataBaseService {
  OnlineDataBase? _onlineDataBase;
  final LocalDatabase _localDatabase;
  static GoogleSignIn? _googleSignIn;

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
    final [rowNumber as int, String tableID as String] = (await Future.wait(
            [_localDatabase.getOnlineTableRowNumber(studentName), _localDatabase.getLessonTableID(lessonName)]))
        .toList();
    final task1 = _localDatabase.createRec(lessonName, studentName, time);
    final task2 = OnlineDataBase.createRec(tableID, rowNumber, time);
    final task3 = _onlineDataBase!.getWorkCount(tableID, rowNumber);
    final result = await Future.wait([task1, task2, task3]);
    if (result[1] == true) {
      await _localDatabase.updateUploadStatus(lessonName, studentName, 1, workCount: result[2] as int?);
    }
  }

  Future<void> deleteRec(String lessonName, String studentName, int? workCount) async {
    final [rowNumber as int, String tableID as String] = (await Future.wait(
            [_localDatabase.getOnlineTableRowNumber(studentName), _localDatabase.getLessonTableID(lessonName)]))
        .toList();
    await OnlineDataBase.deleteRec(tableID, rowNumber, workCount: workCount).then((value) async {
      if (value) {
        await _localDatabase.deleteRec(lessonName, studentName);
      } else {
        await _localDatabase.updateUploadStatus(lessonName, studentName, -1, workCount: workCount);
      }
    }).timeout(const Duration(seconds: 5));
  }

  Future<List<LessonDisplayedEntity>> todayLessons(DateTime today, String studentName) {
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

  static Future<GoogleSignInAccount?> signInGoogle() async {
    _googleSignIn = GoogleSignIn(
      clientId: "233952076286-h6a1rd1lujh8lcr20uhk2dhp2bqhusuh.apps.googleusercontent.com",
      scopes: [
        'https://www.googleapis.com/auth/drive.file',
      ],
    );
    await _googleSignIn!.signOut();
    final user = await _googleSignIn!.signIn();
    return user;
  }

  Future<void> registerGroup(
      List<LessonEntity> lessons, List<StudentEntity> students, String groupLeaderName, String groupName) async {
    if (_googleSignIn?.currentUser == null) {
      await signInGoogle();
    }
    if (_googleSignIn == null) {
      throw Exception("Google sign in not initialized");
    }
    final httpClient = (await _googleSignIn?.authenticatedClient())!;
    final driveApi = DriveApi(httpClient);
    final folderID = await _createFileOnDrive("QueueMinder", 'application/vnd.google-apps.folder', driveApi);
    final infoFileID =
        await _createFileOnDrive("info", "application/vnd.google-apps.spreadsheet", driveApi, folderId: folderID);
    // TODO: autorize user fully
    await set(StoredValues.infoTableID, infoFileID);
    _onlineDataBase = await OnlineDataBase.instance(tableID: infoFileID);
    List<Future<String>> lessonCreation = [];
    for (final lesson in lessons) {
      lessonCreation.add(Future.value(
          _createFileOnDrive(lesson.name, "application/vnd.google-apps.spreadsheet", driveApi, folderId: folderID)
              .then((value) {
        _onlineDataBase!.createFrameOfQueueTable(value);
        return value;
      })));
    }
    final lessonIds = await Future.wait(lessonCreation);
    await Future.wait([
      insertLessons(lessons, lessonIds),
      insertStudents(students),
      _onlineDataBase!.fillGroupInfo(groupLeaderName, groupName)
    ]);
  }

  /// Returns file id
  Future<String> _createFileOnDrive(String name, String fileType, DriveApi driveApi, {String? folderId}) async {
    final infoFile = File(
      parents: folderId == null ? null : [folderId],
      mimeType: fileType,
      name: name,
    );
    final permisson =
        Permission(role: "writer", type: "user", emailAddress: "queue-410@queue-401413.iam.gserviceaccount.com");
    final onlineFile = await driveApi.files.create(infoFile);
    await driveApi.permissions.create(permisson, onlineFile.id!);
    return onlineFile.id!;
  }

  Future<void> insertLessons(List<LessonEntity> lessons, List<String> lessonIds) async {
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

  /// Provide groupLeader's [GoogleSignInAccount] to fetch data from their Google Drive, otherwise data for drive search will be fetched from local database
  Future<void> fetchDataFromDrive({GoogleSignInAccount? account}) async {
    String? infoTableID = (account != null) ? await _findInfoTableOnDrive() : await get(StoredValues.infoTableID);
    if (infoTableID == null) {
      throw Exception("Info table not found");
    }
    _onlineDataBase = await OnlineDataBase.instance(tableID: infoTableID);
    final students = await _onlineDataBase!.getStudents();

    final _ = await Future.wait(
        [_localDatabase.insertStudents(students), _localDatabase.set(StoredValues.infoTableID, infoTableID)]);
    final (lessons, ids) = await _onlineDataBase!.getLessons();
    final result2 = await Future.wait([lessons, ids]);
    await _localDatabase.insertLessons(result2[0] as List<LessonEntity>, result2[1] as List<String>);
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
    final fileList = await driveApi.files
        .list(q: "mimeType = 'application/vnd.google-apps.folder' and trashed = false and name = 'QueueMinder'");
    final count = fileList.files!.length;
    if (_checkFileCount(count)) {
      final folderID = fileList.files!.first.id!;
      final ssFileList = await driveApi.files.list(
          q: "mimeType = 'application/vnd.google-apps.spreadsheet' and trashed = false and parents = '$folderID' and name = 'info'");
      final ssCount = ssFileList.files!.length;
      if (_checkFileCount(ssCount)) {
        return ssFileList.files!.first.id!;
      }
    }
    return null;
  }

  bool _checkFileCount(int count) {
    if (count == 0) {
      throw NoFileFoundOnDiskException("No file found on Google Disk.");
    } else if (count > 1) {
      throw MultipleFilesOnDiskException(
          "Multiple files found on disk. Delete unnecessary files and folders named 'QueueMinder'.");
    }
    return true;
  }

  Future<void> fetchRecs() async {
    final result = await Future.wait([
      _localDatabase.getStudents().then((value) => value.map((e) => [e.onlineTableRowNumber, e.name]).toList()),
      _localDatabase.todayLessons(DateTime.now(), '')
    ]);
    final studentNames = {for (var e in result[0] as List<List>) e[0] as int: e[1] as String};
    final lessonNames = (result[1] as List<LessonDisplayedEntity>).map((e) => e.name);
    for (final lessonName in lessonNames) {
      final recs = await _localDatabase
          .getLessonTableID(lessonName)
          .then((value) async => await _onlineDataBase?.getRecs(studentNames, lessonName, value));
      if (recs != null) {
        await _localDatabase.deleteAllRecs(lessonName);
        await _localDatabase.import(recs);
      }
    }
  }

  // TODO: implement not deleted recs
  Future<bool> postNotUploadedRecs(String studentName) async {
    final [list as List<RecEntity>, rowNumber as int] = (await Future.wait(
            [_localDatabase.getNotUploadedRecs(studentName), _localDatabase.getOnlineTableRowNumber(studentName)]))
        .toList();
    if (list.isEmpty) {
      return false;
    }
    List<Future> tasks = [];
    Map<String, String> map = {};
    for (final rec in list) {
      if (map[rec.lessonName] == null) {
        String tableID = await _localDatabase.getLessonTableID(rec.lessonName);
        map[rec.lessonName] = tableID;
      }
      var recCreation = OnlineDataBase.createRec(map[rec.lessonName]!, rowNumber, rec.time).then((value) async {
        //TODO: test if onlineDataBase is not inited due to
        if (value) await _localDatabase.updateUploadStatus(rec.lessonName, studentName, 1);
      });
      tasks.add(recCreation);
    }
    await Future.wait(tasks);
    return true;
  }

  Future<bool> deleteNotUploadedRecs(String studentName) async {
    final [list as List<RecEntity>, rowNumber as int] = (await Future.wait(
            [_localDatabase.getNotDeletedRecs(studentName), _localDatabase.getOnlineTableRowNumber(studentName)]))
        .toList();
    if (list.isEmpty) {
      return false;
    }
    List<Future> tasks = [];
    Map<String, String> map = {};
    for (final rec in list) {
      if (map[rec.lessonName] == null) {
        String tableID = await _localDatabase.getLessonTableID(rec.lessonName);
        map[rec.lessonName] = tableID;
      }
      var recDeletion =
          OnlineDataBase.deleteRec(map[rec.lessonName]!, rowNumber, workCount: rec.workCount).then((value) async {
        if (value) await _localDatabase.deleteRec(rec.lessonName, studentName);
      });
      tasks.add(recDeletion);
    }
    await Future.wait(tasks);
    return true;
  }

  Future<bool> autoDeleteQeueu() async {
    Future getTask(String id, List tasks) async {
      final lastLessonTime = await _localDatabase.getLastLessonTime(id);
      if (lastLessonTime != null) {
        final shouldDelete = await _onlineDataBase!.checkIfShouldDeleteQueue(id, lastLessonTime);
        if (shouldDelete) {
          tasks.add(_onlineDataBase!.deleteQueue(id));
        }
      }
    }

    try {
      final ids = await _localDatabase.getOnlineIDsOfLessonsToDeleteQueue();
      List<Future> tasks = [];
      Future.wait(ids.map((e) => getTask(e, tasks)));
      Future.wait(tasks);
      return true;
    } catch (e) {
      return false;
    }
  }
}
