import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/new_database_service.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';
import 'package:queue/domain/user_cubit.dart';
import 'package:queue/navigation.dart';

part 'main_screen_cubit.freezed.dart';

class AuthGuard extends AutoRouteGuard {
  final UserCubit _userCubit;
  AuthGuard(this._userCubit);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (_userCubit.isLoggedIn) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      // tip: use resolver.redirect to have the redirected route
      // automatically removed from the stack when the resolver is completed
      resolver.redirect(const TodayRoute());
    }
  }
}

abstract class LoadableCubit<T> extends Cubit<T> {
  LoadableCubit(super.initialState);

  void endLoading();
}

class TodayScreenCubit extends LoadableCubit<TodayScreenState> {
  final DatabaseService _databaseService;
  final UserCubit _userCubit;

  TodayScreenCubit({required DatabaseService databaseService, required UserCubit userCubit})
      : _databaseService = databaseService,
        _userCubit = userCubit,
        super(TodayScreenState.loading()) {
    init();
  }

  late final StreamSubscription _userCubitSubscription;

  Future<void> init() async {
    final todayLessons = await _databaseService.todayLessons();
    final onlineTableIDs = todayLessons.map((e) => e.subjectOnlineTableID).toList();
    final queueRecordList = await _databaseService.getQueueRecords(onlineTableIDs);
    emit(TodayScreenState(newLessonList: todayLessons, recList: queueRecordList, isLoading: LoadingState.loaded));
  }

  Future<void> addNewQueueRecord({required int index}) async {
    final lesson = state.newLessonList[index];
    var queueRec = _getNewQueueRecord(lesson);
    state.recList[lesson.name]!.add(queueRec);
    emit(state);
    final uploaded = await _databaseService.addNewQueueRecord(queueRec, _userCubit.rowNumber);
    if (uploaded) {
      _setLastQueueRecordToUploaded(queueRec, lesson.name);
      emit(state);
    }
  }

  NewQueueRecord _getNewQueueRecord(Lesson lesson) => NewQueueRecord(
        localSubjectID: lesson.subjectLocalID,
        onlineTableID: lesson.subjectOnlineTableID,
        studentRowNumber: _userCubit.rowNumber,
        time: DateTime.now(),
        workCount: _getWorkCount(lesson.name),
        status: NewQueueRecordStatus.shouldBeUploaded,
      );

  int? _getWorkCount(String lessonName) {
    final queueRecords = state.recList[lessonName];
    if (queueRecords == null) return null;
    for (final record in queueRecords) {
      if (record.studentRowNumber == _userCubit.rowNumber) {
        return record.workCount;
      }
    }
    return null;
  }

  void _setLastQueueRecordToUploaded(NewQueueRecord queueRec, String lessonName) {
    queueRec = queueRec.copyWith(status: NewQueueRecordStatus.uploaded);
    state.recList[lessonName]!.removeLast();
    state.recList[lessonName]!.add(queueRec);
  }

  Future<void> deleteQueueRecord({required NewQueueRecord queueRecord}) async {
    final lessons = state.newLessonList.where((element) => element.subjectLocalID == queueRecord.localSubjectID);
    lessons.map((lesson) => state.recList[lesson.name]!.remove(queueRecord));
    emit(state);
    await _databaseService.deleteQueueRecord(queueRecord);
  }

  @override
  Future<void> close() {
    _userCubitSubscription.cancel();
    return super.close();
  }

  @override
  void endLoading() => emit(state.copyWith(isLoading: LoadingState.ended));
}

enum LoadingState { started, loaded, ended, error }

abstract interface class LoadableState {
  final LoadingState isStateLoading;
  const LoadableState(this.isStateLoading);
}

@freezed
class TodayScreenState with _$TodayScreenState implements LoadableState {
  const TodayScreenState._();
  const factory TodayScreenState({
    required List<Lesson> newLessonList,
    required Map<String, List<NewQueueRecord>> recList,
    @Default(LoadingState.loaded) LoadingState isLoading,
    DialogData? dialogData,
  }) = _MainScreenState;
  factory TodayScreenState.loading() =>
      const TodayScreenState(newLessonList: [], recList: {}, isLoading: LoadingState.started);

  @override
  LoadingState get isStateLoading => isLoading;
}

abstract class DialogData {
  String title;
  String message;
  DialogData({required this.title, required this.message});
}

class ErrorDialogData extends DialogData {
  ErrorDialogData({
    required String title,
    required String message,
  }) : super(title: title, message: message);
}

class RequestWorkCountDialogData extends DialogData {
  final int workCount;
  RequestWorkCountDialogData({
    required String title,
    required String message,
    required this.workCount,
  }) : super(title: title, message: message);
}
