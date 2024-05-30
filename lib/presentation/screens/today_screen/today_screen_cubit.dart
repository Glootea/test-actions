import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

part 'today_screen_cubit.freezed.dart';

class TodayScreenCubit extends LoadableCubit<TodayScreenState> {
  final DatabaseService _databaseService;

  TodayScreenCubit({required DatabaseService databaseService, required UserCubit userCubit})
      : _databaseService = databaseService,
        super(TodayScreenState.loading()) {
    init();
  }

  Future<void> init() async {
    final todayLessons = await _databaseService.todayLessons();
    // final onlineTableIDs = todayLessons.map((e) => e.lesson.subjectOnlineTableID).toList();
    // final queueRecordList = await _databaseService.getQueueRecords(onlineTableIDs);
    emit(TodayScreenState(
      separatedLessons: SeparatedLessons.fromLessons(todayLessons),
      isLoading: LoadingState.loaded,
    ));
  }

  @override
  void endLoading() => emit(state.copyWith(isLoading: LoadingState.ended));
}

class SeparatedLessons {
  final List<Lesson> passedLessons;
  final List<Lesson> activeLessons;
  final List<Lesson> futureLessons;

  const SeparatedLessons({
    required this.passedLessons,
    required this.activeLessons,
    required this.futureLessons,
  });

  const SeparatedLessons.empty() : this(passedLessons: const [], activeLessons: const [], futureLessons: const []);

  static SeparatedLessons fromLessons(List<Lesson> lessons) {
    final passedLessons = lessons.where((el) => el.status == LessonStatus.inPast).toList();
    final activeLessons =
        lessons.where((el) => el.status == LessonStatus.active || el.status == LessonStatus.soon).toList();
    final futureLessons = lessons.where((el) => el.status == LessonStatus.inFuture).toList();
    return SeparatedLessons(
      passedLessons: passedLessons,
      activeLessons: activeLessons,
      futureLessons: futureLessons,
    );
  }

  bool get isEmpty => passedLessons.isEmpty && activeLessons.isEmpty && futureLessons.isEmpty;
}

@freezed
class TodayScreenState with _$TodayScreenState implements LoadableState {
  const TodayScreenState._();
  const factory TodayScreenState({
    // required List<Lesson> lessonList,
    required SeparatedLessons separatedLessons,
    @Default(LoadingState.loaded) LoadingState isLoading,
    DialogData? dialogData,
  }) = _MainScreenState;
  factory TodayScreenState.loading() => const TodayScreenState(
        separatedLessons: SeparatedLessons.empty(),
        isLoading: LoadingState.started,
      );

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
    required super.title,
    required super.message,
  });
}

class RequestWorkCountDialogData extends DialogData {
  final int workCount;
  RequestWorkCountDialogData({
    required super.title,
    required super.message,
    required this.workCount,
  });
}
