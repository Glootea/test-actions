import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/domain/user/user_cubit.dart';

part 'main_screen_cubit.freezed.dart';

// class AuthGuard extends AutoRouteGuard {
//   final UserCubit _userCubit;
//   AuthGuard(this._userCubit);
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     // the navigation is paused until resolver.next() is called with either
//     // true to resume/continue navigation or false to abort navigation
//     if (_userCubit.isLoggedIn) {
//       // if user is authenticated we continue
//       resolver.next(true);
//     } else {
//       // we redirect the user to our login page
//       // tip: use resolver.redirect to have the redirected route
//       // automatically removed from the stack when the resolver is completed
//       resolver.redirect(const TodayRoute());
//     }
//   }
// }

abstract class LoadableCubit<T extends LoadableState> extends Cubit<T> {
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
    emit(TodayScreenState(lessonList: todayLessons, recList: queueRecordList, isLoading: LoadingState.loaded));
  }

  @Deprecated("Don't use index. Switch to addNewQueueRecord")
  Future<void> oldAddNewQueueRecord({required int index}) async {
    final lesson = state.lessonList[index];
    var queueRec = _getNewQueueRecord(lesson);
    state.recList[lesson.name]!.add(queueRec);
    emit(state);
    final uploaded = await _databaseService.addNewQueueRecord(queueRec);
    if (uploaded) {
      _setLastQueueRecordToUploaded(queueRec, lesson.name);
      emit(state);
    }
  }

  Future<void> addQueueRecord({required int subjectLocalID}) async {
    final lesson = _databaseService.getLesson(subjectLocalID);
    // final lesson = state.newLessonList[index];
    var queueRec = _getNewQueueRecord(lesson);
    state.recList[lesson.name]!.add(queueRec);
    emit(state);
    final uploaded = await _databaseService.addNewQueueRecord(queueRec);
    if (uploaded) {
      _setLastQueueRecordToUploaded(queueRec, lesson.name);
      emit(state);
    }
  }

  QueueRecord _getNewQueueRecord(Lesson lesson) => QueueRecord(
        localSubjectID: lesson.subjectLocalID,
        onlineTableID: lesson.subjectOnlineTableID,
        studentRowNumber: _userCubit.rowNumber,
        time: DateTime.now(),
        workCount: _getWorkCount(lesson.name),
        status: QueueRecordStatus.shouldBeUploaded,
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

  void _setLastQueueRecordToUploaded(QueueRecord queueRec, String lessonName) {
    queueRec = queueRec.copyWith(status: QueueRecordStatus.uploaded);
    state.recList[lessonName]!.removeLast();
    state.recList[lessonName]!.add(queueRec);
  }

  Future<void> deleteQueueRecord({required QueueRecord queueRecord}) async {
    final lessons = state.lessonList.where((element) => element.subjectLocalID == queueRecord.localSubjectID);
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

  void showQrCode({QueueRecord? queueRecord}) {} // TODO: implement showQrCode

  Future<(QueueRecord, String message)?> getUserQueueData() {
    // TODO: implement getUserQueueData. $2 - message to show on card
    return Future<(QueueRecord, String)?>.value(null);
  }
}

enum LoadingState { noLoading, started, loaded, ended, error }

abstract interface class LoadableState {
  final LoadingState isStateLoading;
  const LoadableState(this.isStateLoading);
}

@freezed
class TodayScreenState with _$TodayScreenState implements LoadableState {
  const TodayScreenState._();
  const factory TodayScreenState({
    required List<Lesson> lessonList,
    required Map<String, List<QueueRecord>> recList,
    @Default(LoadingState.loaded) LoadingState isLoading,
    DialogData? dialogData,
  }) = _MainScreenState;
  factory TodayScreenState.loading() =>
      const TodayScreenState(lessonList: [], recList: {}, isLoading: LoadingState.started);

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
