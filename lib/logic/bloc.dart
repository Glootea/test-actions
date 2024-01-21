// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/providers/local_database.dart';
import 'package:queue/data/database/providers/online_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/data/encryprion.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/optimistic_ui.dart';
import 'package:queue/logic/states.dart';

class QueueBloc extends Bloc<QueueEvent, QueueState> {
  UserDataBase _userDataBase;
  final DataBaseService _databaseService;
  OnlineDataBase get _onlineDB => _databaseService.onlineDataBase;
  String? get userName => _userDataBase.getUserName;
  Uint8List? _bgImageBacked;

  bool get _isAdmin {
    if (state is MainState) {
      return (state as MainState).isAdmin;
    }
    return _userDataBase.isAdmin;
  }

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    return await _databaseService.todayLessons(today, studentName);
  }

  Future<Uint8List> _getBackgroundImage() async {
    String? image = await _databaseService.get(StoredValues.backgroundImage);
    if (image == null) {
      final encoded = await FirebaseStorage.instance.ref("/themes/panda/panda.png").getData().timeout(const Duration(seconds: 5));
      image = base64.encode(encoded!.toList());
      await _databaseService.set(StoredValues.backgroundImage, image);
    }
    _bgImageBacked ??= base64.decode(image); //TODO: implement method to change image in db and notify here
    return _bgImageBacked!;
  }

  QueueBloc(this._userDataBase, this._databaseService, super.initialState) {
    on<QueueEvent>(
      (event, emit) async {
        //  --- mainScreen ---

        if (event is CreateRegEvent)
          await _createReg(event.lessonName, emit);
        else if (event is DeleteRegEvent)
          await _deleteReg(event.lessonName, emit);

        //  --- group creation ---
        else if (event is CreateGroupIntentionEvent)
          await _createGroupIntention(emit);
        else if (event is RegisterGroupEvent)
          await _registerGroup(event, emit);
        else if (event is LoginUsingGoogleEvent)
          _loginUsingGoogle(emit);

        //  --- user Authentication ---
        else if (event is FindUserEvent)
          await _findUser();
        else if (event is NoUserEvent)
          emit(UserUnAuthenticatedState(errorMessage: event.errorMessage));
        else if (event is UserAuthenticatedEvent)
          await _userAuthenticated(emit);
        else if (event is UserLogOutEvent)
          await _userLogOut();

        //  --- upload Screen ---

        else if (event is UploadFromLinkEvent)
          await _uploadExternalRecEvent(event, emit);

        //  --- invite ---

        else if (event is InviteEvent)
          await _onInviteEvent(event, emit);
        else if (event is RegisterInvitedUserEvent) await _onRegisterInvitedUserEvent(event, emit);
      },
      transformer: sequential(),
    );
  }

//---main screen ---

  Future<void> _createReg(String lessonName, Emitter emit) async {
    DateTime time = DateTime.now();
    final fakedLessons = OptimisticUI.createRec((state as MainState).todayLessons, lessonName, time);
    emit(MainState(fakedLessons, _isAdmin));
    await _databaseService.createRec(lessonName, _userDataBase.getUserName, time);
    emit(MainState(await _todayLessons(_userDataBase.getUserName), _isAdmin));
  }

  Future<void> _deleteReg(String lessonName, Emitter emit) async {
    final fakedLessons = OptimisticUI.deleteRec((state as MainState).todayLessons, lessonName);
    emit(MainState(fakedLessons, _isAdmin));
    await _databaseService.deleteRec(lessonName, _userDataBase.getUserName); // TODO: catch network error if occur
    emit(MainState(await _todayLessons(_userDataBase.getUserName), _isAdmin));
    //   //TODO : cache for later upload
  }

  Future<void> _createGroupIntention(Emitter<QueueState> emit) async {
    {
      final user = await _databaseService.signInGoogle();
      if (user != null) {
        emit(UserUnAuthenticatedState(createGroupState: true));
      } else {
        emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
      }
    }
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

  Future<void> _userAuthenticated(Emitter<QueueState> emit) async {
    {
      try {
        // List<RecEntity> list = await _databaseService.getData(); //TODO: fetch recs from online
        // _databaseService.import(list);
      } catch (e) {
        log("Failed to import db due to load failure");
      }
      final result = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
      emit(
        MainState(
          result[0] as List<LessonEntity>,
          _isAdmin,
          backgroundImageDecoded: result[1] as Uint8List,
        ),
      );
      if (await _databaseService.postNotUploadedRecs(_userDataBase.getUserName)) {
        final result = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
        emit(
          MainState(
            result[0] as List<LessonEntity>,
            _isAdmin,
            backgroundImageDecoded: result[1] as Uint8List,
          ),
        );
      }
    }
  }

  Future<void> _loginUsingGoogle(Emitter<QueueState> emit) async {
    final userSignInAccount = await _databaseService.signInGoogle();
    if (userSignInAccount == null) {
      emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
    } else {
      emit(LoadingState());
      await _databaseService.fetchDataFromDrive(account: userSignInAccount);
      _userDataBase =
          await UserDataBase.getConfiguredUserDataBase(_databaseService.localDatabase); // can't use Future.wait as fetchDataFromDrive insert needed data in sb
      final result = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
      emit(MainState(result[0] as List<LessonEntity>, _isAdmin, backgroundImageDecoded: result[1] as Uint8List));
    }
  }

  // --- upload screen

  Future<void> _uploadExternalRecEvent(UploadFromLinkEvent event, Emitter emit) async {
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

  Future<void> _onInviteEvent(InviteEvent event, Emitter<QueueState> emit) async {
    //TODO: implement invite
  }

  Future<void> _onRegisterInvitedUserEvent(RegisterInvitedUserEvent event, Emitter<QueueState> emit) async {
    //TODO: move to database service

    // _userDataBase.fillUser(event.inviteState.userName);
    // _userDataBase = await UserDataBase.getConfiguredUserDataBase(_databaseService);
    // if (_userDataBase.userExist) {
    //   add(NoUserEvent("Пользователь c таким ключем не найден"));
    // } else {
    //   add(UserAuthenticatedEvent());
    // }
  }

  // --- group creation ---

  Future<void> _registerGroup(RegisterGroupEvent event, Emitter<QueueState> emit) async {
    emit(LoadingState());
    final userName = '${event.firstName} ${event.lastName}';
    final result = await Future.wait([
      _userDataBase.fillUser(userName),
      _databaseService.registerGroup(event.lessons, [StudentEntity(userName, 2, isAdmin: true)] + event.students, userName, event.groupName),
      _getBackgroundImage()
    ]);
    emit(MainState(await _todayLessons(userName), true, backgroundImageDecoded: result[2] as Uint8List));
  }
}
