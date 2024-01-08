import 'dart:developer';
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
  OnlineDataBase? _onlineDBBacked;
  Future<OnlineDataBase> get _onlineDB async => _onlineDBBacked ?? await _configureOnlineDB();
  String? backgroundImageEncoded;
  String get userName => _userDataBase.getUserName;
  bool? _isAdminBacked;

  Future<bool> get _isAdmin async {
    _isAdminBacked ??= _userDataBase.isAdmin;
    return _isAdminBacked!;
  }

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    return await _databaseService.todayLessons(today, studentName);
  }

  Future<void> _getBackgroundImage() async {
    backgroundImageEncoded ??= await _databaseService.get(StoredValues.backgroundImage);
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
    on<UserAuthenticateEvent>(
      (event, emit) async => await _authenticateUser(event.userID),
      transformer: sequential(),
    );
    on<UserAuthenticatedEvent>(
      (event, emit) async {
        try {
          List<RecEntity> list = await (await _onlineDB).getData();
          _databaseService.import(list);
        } catch (e) {
          log("Failed to import db due to load failure");
        }
        emit(
          MainState(await _todayLessons(_userDataBase.getUserName), await _isAdmin),
        );
      },
      transformer: sequential(),
    );
    on<UserLogOutEvent>(
      (event, emit) async => await userLogOut(),
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

  Future<void> _authenticateUser(String userName) async {
    // TODO: move to database service
    // _userDataBase.fillUser(userName);
    // _userDataBase = await UserDataBase.getConfiguredUserDataBase(_databaseService);
    // if (_userDataBase.userExist) {
    //   add(NoUserEvent("Пользователь c таким ключем не найден"));
    // } else {
    //   await _getBackgroundImage();
    //   add(UserAuthenticatedEvent());
    // }
  }

  Future<void> userLogOut() async {
    _userDataBase.logOut();

    add(NoUserEvent());
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
      if (await (await _onlineDB).uploadFromQuery(link)) {
        emit(UploadFromLinkState(isLoading: false, message: "Запись успешно добавлена"));
      } else {
        final result = await (await _onlineDB).recExist(link);
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
    await _userDataBase.fillUser(userName);
    await _databaseService.registerGroup(event.lessons, [StudentEntity(userName, isAdmin: true)] + event.students, userName, event.groupName);
    emit(MainState(await _todayLessons(userName), true));
  }

  Future<OnlineDataBase> _configureOnlineDB() async {
    final id = await _databaseService.get(StoredValues.infoTableID);
    // TODO: get map of names to id from db
    if (id == null) throw Exception("Table id not found. Configure database first");
    _onlineDBBacked = await OnlineDataBase.instance(tableID: id);
    print(id);
    return _onlineDBBacked!;
  }

  // Future<void> getData() async {}
}
