import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/providers/local_database.dart';
import 'package:queue/data/database/providers/online_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/data/encryprion.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase _userDataBase;
  final DataBaseService _databaseService;
  OnlineDataBase get _onlineDB => _databaseService.onlineDataBase;
  Uint8List? _bgImageBacked;
  String? get userName => _userDataBase.getUserName;
  bool? _isAdminBacked;

  Future<bool> get _isAdmin async {
    _isAdminBacked ??= _userDataBase.isAdmin;
    return _isAdminBacked!;
  }

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    return await _databaseService.todayLessons(today, studentName);
  }

  Future<Uint8List> _getBackgroundImage() async {
    _bgImageBacked =
        base64.decode(await _databaseService.get(StoredValues.backgroundImage) ?? ''); //TODO: implement method to change image in db and notify here
    return _bgImageBacked!;
  }

  QueueBloc(this._userDataBase, this._databaseService, super.initialState) {
    // --- loading

    // --- user Authentication ---

    on<FindUserEvent>(
      (event, emit) async => await _findUser(),
      transformer: sequential(),
    );
    on<NoUserEvent>(
      (event, emit) => emit(UserUnAuthenticatedState(errorMessage: event.errorMessage)),
      transformer: sequential(),
    );
    // on<UserAuthenticateEvent>(
    //   (event, emit) async => await _authenticateUser(event.userID),
    //   transformer: sequential(),
    // );
    on<UserAuthenticatedEvent>(
      (event, emit) async {
        try {
          // List<RecEntity> list = await _databaseService.getData(); //TODO: fetch recs from online
          // _databaseService.import(list);
        } catch (e) {
          log("Failed to import db due to load failure");
        }
        final result = await Future.wait([_todayLessons(_userDataBase.getUserName!), _isAdmin, _getBackgroundImage()]);
        emit(
          MainState(
            result[0] as List<LessonEntity>,
            result[1] as bool,
            backgroundImageDecoded: result[2] as Uint8List,
          ),
        );
      },
      transformer: sequential(),
    );
    on<UserLogOutEvent>(
      (event, emit) async => await _userLogOut(),
      transformer: sequential(),
    );

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
    on<RegisterUserEvent>((event, emit) async => await _onRegisterUserEvent(event, emit));

    // login screen

    on<CreateGroupIntentionEvent>((event, emit) async {
      final user = await _databaseService.signInGoogle();
      if (user != null) {
        emit(UserUnAuthenticatedState(createGroupState: true));
      } else {
        emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
      }
    });

    on<RegisterGroupEvent>((event, emit) async => await _registerGroup(event, emit));
    on<LoginUsingGoogleEvent>((event, emit) => _loginUsingGoogle(emit));
  }

// --- Functions

  // --- user Authentication ---
  Future<void> _findUser() async {
    if (_userDataBase.userExist) {
      add(UserAuthenticatedEvent());
    } else {
      add(NoUserEvent());
    }
  }

  Future<void> _userLogOut() async {
    add(NoUserEvent());
    _userDataBase.logOut();
  }

//---main screen ---

  Future<void> _createReg(String lessonName, Emitter emit) async {
    // TODO: move to database service
    //   DateTime time = DateTime.now();
    //   await _databaseService.createRec(lessonName, _userDataBase.getUserName, time);
    //   emit(MainState(await _todayLessons(_userDataBase.getUserName), await _isAdmin));
    //   bool isOnline = await (await _onlineDB).createRec(lessonName, _userDataBase.getUserName, time);
    //   if (isOnline == true) {
    //     _databaseService.updateUploadStatus(lessonName, _userDataBase.getUserName, true);
    //     emit(MainState(await _todayLessons(_userDataBase.getUserName), await _isAdmin));
    //   } else {
    //     _databaseService.updateUploadStatus(lessonName, _userDataBase.getUserName, false);
    //     //TODO : cache for later upload
    //   }
    // }
  }
  Future<void> _deleteReg(String lessonName, Emitter emit) async {
    //   await _databaseService.deleteRec(lessonName, _userDataBase.getUserName);
    //   emit(MainState(await _todayLessons(_userDataBase.getUserName), await _isAdmin));
    //   bool isOnline = await (await _onlineDB).deleteRec(lessonName, _userDataBase.getUserName);
    //   if (isOnline == true) {
    //     _databaseService.deleteRec(lessonName, _userDataBase.getUserName);
    //     emit(MainState(await _todayLessons(_userDataBase.getUserName), await _isAdmin));
    //   }
    //else {
    //   //TODO : cache for later upload
  }

  // --- upload screen

  Future<void> _onUploadEvent(UploadFromLinkEvent event, Emitter emit) async {
    try {
      String link = Encryption.decrypt(event.link);
      emit(UploadFromLinkState(isLoading: true));
      if (await (_onlineDB).uploadFromQuery(link)) {
        emit(UploadFromLinkState(isLoading: false, message: "Запись успешно добавлена"));
      } else {
        final result = await (_onlineDB).recExist(link);
        if (result != null) {
          emit(UploadFromLinkState(
              isLoading: false,
              message:
                  "Запись уже добавлена. ${result['name']} находится на ${result['position']} месте в очереди ${result['position'] == '1' ? '.' : 'после ${result['last']}'}"));
        } else {
          emit(UploadFromLinkState(isLoading: false, message: "Ошибка при добавлении записи"));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(UploadFromLinkState(isLoading: false, message: "Ошибка при добавлении записи"));
    }
  }

  void _onInviteEvent(InviteEvent event, Emitter<QueueState> emit) {
    //TODO: implement invite
  }

  Future<void> _onRegisterUserEvent(RegisterUserEvent event, Emitter<QueueState> emit) async {
    //TODO: move to database service

    // _userDataBase.fillUser(event.inviteState.userName);
    // _userDataBase = await UserDataBase.getConfiguredUserDataBase(_databaseService);
    // if (_userDataBase.userExist) {
    //   add(NoUserEvent("Пользователь c таким ключем не найден"));
    // } else {
    //   add(UserAuthenticatedEvent());
    // }
  }

  Future<void> _registerGroup(RegisterGroupEvent event, Emitter<QueueState> emit) async {
    final userName = '${event.firstName} ${event.lastName}';
    await Future.wait([
      _userDataBase.fillUser(userName),
      _databaseService.registerGroup(event.lessons, [StudentEntity(userName, isAdmin: true)] + event.students, userName, event.groupName)
    ]);
    emit(MainState(await _todayLessons(userName), true));
  }

  Future<void> _loginUsingGoogle(Emitter<QueueState> emit) async {
    final userSignInAccount = await _databaseService.signInGoogle();
    if (userSignInAccount == null) {
      emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
    } else {
      await _databaseService.fetchDataFromDrive(account: userSignInAccount);
      _userDataBase =
          await UserDataBase.getConfiguredUserDataBase(_databaseService.localDatabase); // can't use Future.wait as fetchDataFromDrive insert needed data in sb
      final result = await Future.wait([_todayLessons(_userDataBase.getUserName!), _isAdmin]);
      emit(MainState(result[0] as List<LessonEntity>, result[1] as bool));
    }
  }

  // Future<void> getData() async {}
}
