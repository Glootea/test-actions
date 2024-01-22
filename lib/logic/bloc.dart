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
import 'package:queue/data/qr_code_data.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/entities/export.dart';
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
        switch (event.runtimeType) {
          //  --- mainScreen ---
          case CreateRegEvent:
            await _createReg((event as CreateRegEvent).lessonName, emit);
          case DeleteRegEvent:
            await _deleteReg((event as DeleteRegEvent).lessonName, emit);
          case ShowQRCodeEvent:
            await _showQrCode(event as ShowQRCodeEvent, emit);
          //  --- group creation ---
          case CreateGroupIntentionEvent:
            await _createGroupIntention(emit);
          case RegisterGroupEvent:
            await _registerGroup((event as RegisterGroupEvent), emit);
          case LoginUsingGoogleEvent:
            await _loginUsingGoogle(emit);

          //  --- user Authentication ---
          case FindUserEvent:
            await _findUser();
          case NoUserEvent:
            emit(UserUnAuthenticatedState(errorMessage: (event as NoUserEvent).errorMessage));
          case UserAuthenticatedEvent:
            await _userAuthenticated(emit);
          case UserLogOutEvent:
            await _userLogOut();

          //  --- upload Screen ---

          case UploadFromLinkEvent:
            await _uploadExternalRecEvent(event as UploadFromLinkEvent, emit);

          //  --- invite ---

          case InviteEvent:
            await _onInviteEvent(event as InviteEvent, emit);
          case RegisterInvitedUserEvent:
            await _onRegisterInvitedUserEvent(event as RegisterInvitedUserEvent, emit);
        }
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

  Future<void> _showQrCode(ShowQRCodeEvent event, Emitter emit) async {
    final (tableID, rowNumber) =
        await (_databaseService.localDatabase.getLessonTableID(event.lessonName), _databaseService.localDatabase.getOnlineTableRowNumber(userName!)).wait;
    final data = QrCodeData.toQrData(tableID, rowNumber, event.time);
    final mainState = state as MainState;
    emit(ShowQRCodeState(data, mainState.todayLessons, mainState.isAdmin));
  }

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
      final result = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
      emit(
        MainState(
          result[0] as List<LessonEntity>,
          _isAdmin,
          backgroundImageDecoded: result[1] as Uint8List,
        ),
      );
      final tasks = [_databaseService.postNotUploadedRecs(_userDataBase.getUserName), _databaseService.deleteNotUploadedRecs(_userDataBase.getUserName)];
      if (await Future.wait(tasks).then((value) => value.any((e) => e == true))) {
        final result = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
        emit(
          MainState(
            result[0] as List<LessonEntity>,
            _isAdmin,
            backgroundImageDecoded: result[1] as Uint8List,
          ),
        );
      }
      await _databaseService.fetchRecs(); //TODO: fetch recs from online
      final result2 = await Future.wait([_todayLessons(_userDataBase.getUserName), _getBackgroundImage()]);
      emit(
        MainState(
          result2[0] as List<LessonEntity>,
          _isAdmin,
          backgroundImageDecoded: result2[1] as Uint8List,
        ),
      );
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
      // String link = Encryption.decrypt(event.link.substring(event.link.lastIndexOf('/') + 1));
      final (String tableID, int rowNumber, DateTime time) = QrCodeData.fromQrData(event.link);
      emit(UploadFromLinkState(isLoading: true));
      await _onlineDB.createRec(tableID, rowNumber, time);
      emit(UploadFromLinkState(isLoading: false, message: "Запись успешно добавлена"));
      // if () {
      // } else {
      //   final result = await _onlineDB.recExist(link);
      //   if (result != null) {
      //     emit(UploadFromLinkState(
      //         isLoading: false,
      //         message:
      //             "Запись уже добавлена. ${result['name']} находится на ${result['position']} месте в очереди ${result['position'] == '1' ? '.' : 'после ${result['last']}'}"));
      //   } else {
      //     emit(UploadFromLinkState(isLoading: false, message: "Ошибка при добавлении записи"));
      //   }
      // }
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
