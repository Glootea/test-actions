import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queue/data/database/database.dart';
import 'package:queue/data/online_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/entities/rec.dart';
import 'package:queue/logic/encryprion.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:firebase_storage/firebase_storage.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase? _userDataBase;
  final LocalDatabase _localDataBase;
  final OnlineDataBase _onlineDB = OnlineDataBase();
  String? backgroundImageEncoded;
  String get userName => _userDataBase!.getUserName;
  bool? _isAdminBacked;
  Future<bool> get _isAdmin async {
    _isAdminBacked ??= await _localDataBase.isAdmin(userName);
    return _isAdminBacked!;
  }

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    int weekDay = today.weekday;
    return await _localDataBase.todayLessons(today, weekDay, studentName);
  }

  Future<void> _getBackgroundImage() async {
    backgroundImageEncoded ??= await _localDataBase.getBackgroundImage();
  }

  QueueBloc(this._userDataBase, this._localDataBase, super.initialState) {
    // --- loading

    // --- user Authentication ---

    on<FindUserEvent>(
      (event, emit) async => await _findUser(),
      transformer: sequential(),
    );
    on<NoUserEvent>(
      (event, emit) => emit(UserUnAuthenticatedState(event.errorMessage)),
      transformer: sequential(),
    );
    on<UserAuthenticateEvent>(
      (event, emit) async => await _authenticateUser(event.userID),
      transformer: sequential(),
    );
    on<UserAuthenticatedEvent>(
      (event, emit) async {
        try {
          List<RecEntity> list = await _onlineDB.getData();
          _localDataBase.import(list);
        } catch (e) {
          log("Failed to import db due to load failure");
        }
        emit(
          MainState(
              await _todayLessons(_userDataBase!.getUserName), await _isAdmin),
        );
      },
      transformer: sequential(),
    );
    on<UserLogOutEvent>(
      (event, emit) async => await userLogOut(),
      transformer: sequential(),
    );

    on<CreateGroupEvent>((event, emit) async => await _createGroup());
//---mainScreen ---

    on<CreateRegEvent>(
      (event, emit) async => await _createReg(event.lessonName, emit),
      transformer: sequential(),
    );
    on<DeleteRegEvent>(
      (event, emit) async => await _deleteReg(event.lessonName, emit),
      transformer: sequential(),
    );

    // --- uploadScreen

    on<UploadFromLinkEvent>((event, emit) => _onUploadEvent(event, emit));

    // --- invite

    on<InviteEvent>((event, emit) => _onInviteEvent(event, emit));
    on<RegisterUserEvent>(
        (event, emit) async => await _onRegisterUserEvent(event, emit));
  }

// --- Functions

  // --- user Authentication ---
  Future<void> _findUser() async {
    if (_userDataBase == null) {
      add(NoUserEvent());
    } else {
      add(UserAuthenticatedEvent());
    }
  }

  Future<void> _authenticateUser(String userName) async {
    await UserDataBase.fillUser(userName);
    _userDataBase = await UserDataBase.configuredUserDataBase();
    if (_userDataBase == null) {
      add(NoUserEvent("Пользователь c таким ключем не найден"));
    } else {
      await _getBackgroundImage();
      add(UserAuthenticatedEvent());
    }
  }

  Future<void> userLogOut() async {
    await _userDataBase?.logOut();
    _userDataBase = null;
    add(NoUserEvent());
  }

//---main screen ---

  Future<void> _createReg(String lessonName, Emitter emit) async {
    DateTime time = DateTime.now();
    await _localDataBase.createRec(
        lessonName, _userDataBase!.getUserName, time);
    emit(MainState(
        await _todayLessons(_userDataBase!.getUserName), await _isAdmin));
    bool isOnline =
        await _onlineDB.createRec(lessonName, _userDataBase!.getUserName, time);
    if (isOnline == true) {
      _localDataBase.updateUploadStatus(
          lessonName, _userDataBase!.getUserName, true);
      emit(MainState(
          await _todayLessons(_userDataBase!.getUserName), await _isAdmin));
    } else {
      _localDataBase.updateUploadStatus(
          lessonName, _userDataBase!.getUserName, false);
      //TODO : cache for later upload
    }
  }

  Future<void> _deleteReg(String lessonName, Emitter emit) async {
    await _localDataBase.deleteRec(lessonName, _userDataBase!.getUserName);
    emit(MainState(
        await _todayLessons(_userDataBase!.getUserName), await _isAdmin));
    bool isOnline =
        await _onlineDB.deleteRec(lessonName, _userDataBase!.getUserName);
    if (isOnline == true) {
      _localDataBase.deleteRec(lessonName, _userDataBase!.getUserName);
      emit(MainState(
          await _todayLessons(_userDataBase!.getUserName), await _isAdmin));
    }
    //else {
    //   //TODO : cache for later upload
    // }
  }

  // --- upload screen

  Future<void> _onUploadEvent(UploadFromLinkEvent event, Emitter emit) async {
    try {
      String link = Encryption.decrypt(event.link);
      emit(UploadFromLinkState(isLoading: true));
      if (await _onlineDB.uploadFromQuery(link)) {
        emit(UploadFromLinkState(
            isLoading: false, message: "Запись успешно добавлена"));
      } else {
        final result = await _onlineDB.recExist(link);
        if (result != null) {
          emit(UploadFromLinkState(
              isLoading: false,
              message:
                  "Запись уже добавлена. ${result['name']} находится на ${result['position']} месте в очереди ${result['position'] == '1' ? '.' : 'после ${result['last']}'}"));
        } else {
          emit(UploadFromLinkState(
              isLoading: false, message: "Ошибка при добавлении записи"));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(UploadFromLinkState(
          isLoading: false, message: "Ошибка при добавлении записи"));
    }
  }

  void _onInviteEvent(InviteEvent event, Emitter<QueueState> emit) {
    //TODO: implement invite
  }

  Future<void> _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<QueueState> emit) async {
    await UserDataBase.fillUser(event.inviteState.userName);
    _userDataBase = await UserDataBase.configuredUserDataBase();
    if (_userDataBase == null) {
      add(NoUserEvent("Пользователь c таким ключем не найден"));
    } else {
      add(UserAuthenticatedEvent());
    }
  }

  Future<void> _createGroup() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "842227545035-m0m949sgn56qkfqsgscb5lgrdpoog82l.apps.googleusercontent.com",
      scopes: [
        'https://www.googleapis.com/auth/drive.file',
      ],
    );

    await googleSignIn.signIn();
    final httpClient = (await googleSignIn.authenticatedClient())!;
    final driveApi = DriveApi(httpClient);
    final folder = await driveApi.files.create(File(
        mimeType: 'application/vnd.google-apps.folder', name: "Очередь работ"));
    final file = File(
      parents: [folder.id!],
      mimeType:
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      name: "Очередь работ",
    );
    final storage = FirebaseStorage.instance
        .ref()
        .child("defaultTable")
        .child("queue.xlsx");
    final data = await storage.getData();
    final stream = List<int>.from(data!.toList()).map((e) => [e]);
    Media media = Media(Stream.fromIterable(stream), stream.length);
    final onlineFile = await driveApi.files.create(file, uploadMedia: media);
    final permisson = Permission(role: "writer", type: "anyone");
    await driveApi.permissions.create(permisson, onlineFile.id!);
    log(onlineFile.id!);
  }

  // Future<void> getData() async {}
}
