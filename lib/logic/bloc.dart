import 'package:bloc/bloc.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/models/lesson.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase? _userDataBase;
  List<Lesson>? _todayLessons;
  QueueBloc(super.initialState) {
    // --- loading

    // --- user Authentication ---

    on<FindUserEvent>((event, emit) async => await _findUser());
    on<NoUserEvent>(
        (event, emit) => emit(UserUnAuthenticatedState(event.errorMessage)));
    on<UserAuthenticateEvent>(
        (event, emit) async => await _authenticateUser(event.userID));
    on<UserAuthenticatedEvent>(
        (event, emit) => emit(MainState(_todayLessons ?? [])));
    on<UserLogOutEvent>((event, emit) async => await userLogOut());
    add(FindUserEvent());
  }

  // --- user Authentication ---
  Future<void> _findUser() async {
    _userDataBase = await UserDataBase.configuredUserDataBase();
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

  Future<void> getData() async {}
}
