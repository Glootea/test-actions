import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:queue/data/lesson_database.dart';
import 'package:queue/data/online_database.dart';

import 'package:queue/data/user_database.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/models/lesson.dart';
import 'package:queue/models/rec.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase? _userDataBase;
  final LessonDatabase _lessonDatabase;
  final OnlineDataBase _onlineDB = OnlineDataBase();

  List<Lesson>? get _todayLessons => _lessonDatabase.todayLessons;
  QueueBloc(this._userDataBase, this._lessonDatabase, super.initialState) {
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
        Map<String, List<Rec>> map =
            await _onlineDB.getData(_userDataBase?.getUserName ?? 'none');

        for (final entry in map.entries) {
          _lessonDatabase.import(
              entry.key, entry.value, _userDataBase?.getUserName ?? 'none');
        }
        emit(
          MainState(_todayLessons ?? []),
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
    add(FindUserEvent());
  }

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
    _lessonDatabase.createRec(
        lessonName, _userDataBase!.getUserName, false, time);
    emit(MainState(_todayLessons ?? []));
    bool isOnline =
        await _onlineDB.createRec(lessonName, _userDataBase!.getUserName, time);
    if (isOnline == true) {
      _lessonDatabase.updateRec(
          lessonName, _userDataBase!.getUserName, true, time);
      emit(MainState(_todayLessons ?? []));
    } else {
      //TODO : cache for later upload
    }
  }

  Future<void> _deleteReg(String lessonName, Emitter emit) async {
    _lessonDatabase.deleteReg(lessonName, _userDataBase!.getUserName);
    emit(MainState(_todayLessons ?? []));
    bool isOnline =
        await _onlineDB.deleteRec(lessonName, _userDataBase!.getUserName);
    if (isOnline == true) {
      _lessonDatabase.deleteReg(lessonName, _userDataBase!.getUserName);
      emit(MainState(_todayLessons ?? []));
    }
    //else {
    //   //TODO : cache for later upload
    // }
  }

  Future<void> getData() async {}
}
