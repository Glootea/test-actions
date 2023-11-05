import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:queue/data/database/database.dart';
import 'package:queue/data/online_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/entities/rec.dart';
import 'package:queue/logic/encryprion.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase? _userDataBase;
  final LocalDatabase _localDataBase;
  final OnlineDataBase _onlineDB = OnlineDataBase();

  String get userName => _userDataBase!.getUserName;

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    int weekDay = today.weekday;
    return await _localDataBase.todayLessons(today, weekDay, studentName);
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
          MainState(await _todayLessons(_userDataBase!.getUserName)),
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

  Future<void> _authenticateUser(String userID) async {
    await UserDataBase.fillUser(userID);
    _userDataBase = await UserDataBase.configuredUserDataBase();
    if (_userDataBase == null) {
      add(NoUserEvent("Пользователь c таким ключем не найден"));
    } else {
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
    _localDataBase.createRec(lessonName, _userDataBase!.getUserName, time);
    emit(MainState(await _todayLessons(_userDataBase!.getUserName)));
    bool isOnline =
        await _onlineDB.createRec(lessonName, _userDataBase!.getUserName, time);
    if (isOnline == true) {
      _localDataBase.updateUploadStatus(
          lessonName, _userDataBase!.getUserName, true);
      emit(MainState(await _todayLessons(_userDataBase!.getUserName)));
    } else {
      _localDataBase.updateUploadStatus(
          lessonName, _userDataBase!.getUserName, false);
      //TODO : cache for later upload
    }
  }

  Future<void> _deleteReg(String lessonName, Emitter emit) async {
    _localDataBase.deleteRec(lessonName, _userDataBase!.getUserName);
    emit(MainState(await _todayLessons(_userDataBase!.getUserName)));
    bool isOnline =
        await _onlineDB.deleteRec(lessonName, _userDataBase!.getUserName);
    if (isOnline == true) {
      _localDataBase.deleteRec(lessonName, _userDataBase!.getUserName);
      emit(MainState(await _todayLessons(_userDataBase!.getUserName)));
    }
    //else {
    //   //TODO : cache for later upload
    // }
  }

  // --- upload screen

  Future<void> _onUploadEvent(UploadFromLinkEvent event, Emitter emit) async {
    try {
      String link = Encryption.decrypt(
          event.link.substring(event.link.indexOf('info=') + 5));
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

  // Future<void> getData() async {}
}
