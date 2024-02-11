// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/providers/local_database/local_database.dart';
import 'package:queue/data/database/providers/online_database/online_database.dart';
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

  Future<bool> get getUpdateEnabled async {
    return _databaseService.localDatabase
        .get(StoredValues.shouldUpdate)
        .then((value) => value == 'true' || value == null);
  }

  Future<List<LessonEntity>> _todayLessons(String studentName) async {
    DateTime today = DateTime.now();
    return await _databaseService.todayLessons(today, studentName);
  }

  Future<Uint8List> _getBackgroundImage() async {
    String? image = await _databaseService.get(StoredValues.backgroundImage);
    if (image == null) {
      final encoded =
          await FirebaseStorage.instance.ref("/themes/panda/panda.png").getData().timeout(const Duration(seconds: 5));
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
            await _deleteReg((event as DeleteRegEvent), emit);
          case ShowQRCodeEvent:
            await _showQrCode(event as ShowQRCodeEvent, emit);
          case ToggleUpdateEvent:
            await _onToggleUpdate(emit);
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
          case SignMeInEvent:
            await _signMeIn(emit);
          //  --- invite ---

          case ReceivedInviteEvent:
            await _onInviteEvent(event as ReceivedInviteEvent, emit);
          case RegisterInvitedUserEvent:
            await _onRegisterInvitedUserEvent(event as RegisterInvitedUserEvent, emit);

          // --- admin screen ---
          case NavigateToAdminSettingEvent:
            emit(AdminSettingState((event as NavigateToAdminSettingEvent).index));
          default:
            throw UnimplementedError("Event ${event.runtimeType} is not implemented in queue bloc");
        }
      },
      transformer: sequential(),
    );
  }

//---main screen ---

  Future<void> _createReg(String lessonName, Emitter emit) async {
    DateTime time = DateTime.now();
    final fakedLessons = OptimisticUI.createRec((state as MainState).todayLessons, lessonName, time);
    await _emitMainState(emit, todayLessons: fakedLessons, processingActive: true);
    await _databaseService.createRec(lessonName, _userDataBase.getUserName, time);
    await _emitMainState(emit);
  }

  Future<void> _deleteReg(DeleteRegEvent event, Emitter emit) async {
    final fakedLessons = OptimisticUI.deleteRec((state as MainState).todayLessons, event.lessonName);
    await _emitMainState(emit, todayLessons: fakedLessons, processingActive: true);
    await _databaseService.deleteRec(
        event.lessonName, _userDataBase.getUserName, event.workCount); // TODO: catch network error if occur
    await _emitMainState(emit);
    //   //TODO : cache for later upload
  }

  Future<void> _onToggleUpdate(Emitter emit) async {
    final prevShouldUpdate =
        ((await _databaseService.localDatabase.get(StoredValues.shouldUpdate)) ?? 'true') == 'true';
    await _databaseService.localDatabase.set(StoredValues.shouldUpdate, prevShouldUpdate ? 'false' : 'true');
    await _emitMainState(emit, updateEnabled: !prevShouldUpdate);
  }

  Future<void> _showQrCode(ShowQRCodeEvent event, Emitter emit) async {
    final (tableID, rowNumber) = await (
      _databaseService.localDatabase.getLessonTableID(event.lessonName),
      _databaseService.localDatabase.getOnlineTableRowNumber(userName!)
    ).wait;
    final data = QrCodeData.toQrData(tableID, rowNumber, event.time);
    final mainState = state as MainState;
    emit(ShowQRCodeState(data, mainState.todayLessons, mainState.isAdmin, mainState.updateEnabled, false));
  }

  Future<void> _signMeIn(Emitter<QueueState> emit) async {
    final time = DateTime.now();
    if (_userDataBase.userExist == false) return add(FindUserEvent());
    final name = _userDataBase.getUserName;
    final lessons = await _todayLessons(name);
    await Future.wait(lessons.map(
        (lesson) => lesson.regIsActive ? _databaseService.createRec(lesson.name, name, time) : Future.value(true)));
    await _emitMainState(emit);
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
      await _emitMainState(emit, processingActive: true);
      final tasks = [
        _databaseService.postNotUploadedRecs(_userDataBase.getUserName),
        _databaseService.deleteNotUploadedRecs(_userDataBase.getUserName),
        _databaseService.autoDeleteQeueu()
      ];
      if (await Future.wait(tasks).then((value) => value.any((e) => e == true))) {
        await _emitMainState(emit, processingActive: true);
      }
      await _databaseService.fetchRecs();
      await _emitMainState(emit);
    }
  }

  Future<void> _loginUsingGoogle(Emitter<QueueState> emit) async {
    //TODO: refactor
    final userSignInAccount = await DataBaseService.signInGoogle();
    if (userSignInAccount == null) {
      emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
    } else {
      emit(LoadingState());
      await _databaseService.fetchDataFromDrive(account: userSignInAccount);
      await _databaseService.set(StoredValues.userName, await _databaseService.onlineDataBase.getHeadName());
      final result = await (
        UserDataBase.getConfiguredUserDataBase(_databaseService.localDatabase),
        _databaseService.fetchRecs()
      ).wait;
      _userDataBase = result.$1;
      await _emitMainState(emit);
    }
  }

  Future<void> _onRegisterInvitedUserEvent(RegisterInvitedUserEvent event, Emitter<QueueState> emit) async {
    emit(LoadingState());
    log(event.infoTableID);
    log("Loading");
    await (
      _databaseService.localDatabase.set(StoredValues.userName, event.studentName),
      _databaseService.localDatabase.set(StoredValues.infoTableID, event.infoTableID)
    ).wait;
    await _databaseService.fetchDataFromDrive();
    await _databaseService.fetchRecs();
    _userDataBase = await UserDataBase.getConfiguredUserDataBase(
        _databaseService.localDatabase); // can't use Future.wait as fetchDataFromDrive insert needed data in sb
    await _emitMainState(emit);
  }

  // --- upload screen

  Future<void> _uploadExternalRecEvent(UploadFromLinkEvent event, Emitter emit) async {
    try {
      // String link = Encryption.decrypt(event.link.substring(event.link.lastIndexOf('/') + 1));
      final (String tableID, int rowNumber, DateTime time) = QrCodeData.fromQrData(event.link);
      emit(UploadFromLinkState(isLoading: true, loadedPosition: false));
      await OnlineDataBase.createRec(tableID, rowNumber, time);
      emit(UploadFromLinkState(isLoading: false, loadedPosition: false, message: "Запись успешно добавлена"));
      final (position, last) = await OnlineDataBase.getQueuePosition(tableID, rowNumber);
      emit(UploadFromLinkState(
          isLoading: false,
          loadedPosition: true,
          message:
              "Запись успешно добавлена\n Вы занимаете $position место в очереди${last != null ? ' после $last' : ''}"));
    } catch (e) {
      log(e.toString());
      emit(UploadFromLinkState(isLoading: false, loadedPosition: false, message: "Ошибка при добавлении записи"));
    }
  }

  Future<void> _onInviteEvent(ReceivedInviteEvent event, Emitter<QueueState> emit) async {
    emit(ReceivedInviteState(event.tableID));
  }

  // --- group creation ---

  Future<void> _registerGroup(RegisterGroupEvent event, Emitter<QueueState> emit) async {
    emit(LoadingState());
    await Future.wait([
      _userDataBase.fillUser(event.name),
      _databaseService.registerGroup(
          event.lessons, [StudentEntity(event.name, 2, isAdmin: true)] + event.students, event.name, event.groupName),
    ]);
    await _emitMainState(emit, isAdmin: true);
  }

  Future<void> _createGroupIntention(Emitter<QueueState> emit) async {
    {
      final user = await DataBaseService.signInGoogle();
      if (user != null) {
        emit(UserUnAuthenticatedState(createGroupState: true));
      } else {
        emit(UserUnAuthenticatedState(errorMessage: "Пользователь не авторизован"));
      }
    }
  }

  Future<void> _emitMainState(Emitter emit,
      {List<LessonEntity>? todayLessons,
      bool? isAdmin,
      Uint8List? backgroundImageDecoded,
      bool? updateEnabled,
      bool? processingActive}) async {
    final result = await Future.wait([
      todayLessons == null ? _todayLessons(_userDataBase.getUserName) : Future.value(null),
      isAdmin == null ? Future.value(_isAdmin) : Future.value(null),
      backgroundImageDecoded == null ? _getBackgroundImage() : Future.value(null),
      updateEnabled == null ? getUpdateEnabled : Future.value(null)
    ]);
    todayLessons ??= result[0] as List<LessonEntity>;
    isAdmin ??= result[1] as bool;
    backgroundImageDecoded ??= result[2] as Uint8List;
    updateEnabled ??= result[3] as bool;
    emit(MainState(
      todayLessons,
      isAdmin,
      updateEnabled,
      processingActive ?? false,
      backgroundImageDecoded: backgroundImageDecoded,
    ));
  }
}
