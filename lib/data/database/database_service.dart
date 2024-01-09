import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queue/data/database/providers/local_database.dart';
import 'package:queue/data/database/providers/online_database.dart';
import 'package:queue/entities/export.dart';
import 'package:googleapis/drive/v3.dart';

class DataBaseService {
  OnlineDataBase? _onlineDataBase;
  final LocalDatabase _localDatabase;
  GoogleSignIn? _googleSignIn;

  DataBaseService._(this._localDatabase, this._onlineDataBase);

  LocalDatabase get localDatabase => _localDatabase;

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
    final task1 = _localDatabase.createRec(lessonName, studentName, time);
    final task2 = _onlineDataBase?.createRec(lessonName, studentName, time) ?? Future.value(false);
    final result = await Future.wait([task1, task2]);
    if (result[1] == true) {
      _localDatabase.updateUploadStatus(lessonName, studentName, true);
    }
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
    if (kIsWeb) {
      _googleSignIn = GoogleSignIn(
        clientId: "842227545035-m0m949sgn56qkfqsgscb5lgrdpoog82l.apps.googleusercontent.com",
        scopes: [
          'https://www.googleapis.com/auth/drive.file',
        ],
      );
    } else {
      _googleSignIn = GoogleSignIn(
        serverClientId: "842227545035-m0m949sgn56qkfqsgscb5lgrdpoog82l.apps.googleusercontent.com",
        scopes: [
          'https://www.googleapis.com/auth/drive.file',
        ],
      );
    }
    await _googleSignIn!.signOut();
    final user = await _googleSignIn!.signIn();
    return user;
  }

  Future<void> registerGroup(List<LessonSettingEntity> lessons, List<StudentEntity> students, String headManName, String groupName) async {
    if (_googleSignIn?.currentUser == null) {
      await _googleSignIn?.signIn();
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
      lessonCreation.add(Future.value(_createSpreadSheetFileOnDrive(folder.id!, lesson.name, driveApi)));
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
    Future.wait([_localDatabase.insertStudents(students), _onlineDataBase!.fillStudents(students)]);
  }
}
