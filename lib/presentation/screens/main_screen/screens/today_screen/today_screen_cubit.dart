import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

part 'today_screen_cubit.freezed.dart';

class TodayScreenCubit extends LoadableCubit<TodayScreenState> {
  TodayScreenCubit._({required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(TodayScreenState.loading());

  final DatabaseService _databaseService;

  static Future<TodayScreenCubit> create(DatabaseService databaseService) async {
    final cubit = TodayScreenCubit._(databaseService: databaseService);
    await cubit._init();
    return cubit;
  }

  Future<void> _init() async {
    final todayLessons = await _databaseService.todayLessons();
    // final onlineTableIDs = todayLessons.map((e) => e.lesson.subjectOnlineTableID).toList();
    // final queueRecordList = await _databaseService.getQueueRecords(onlineTableIDs);
    emit(
      TodayScreenState(
        separatedLessons: SeparatedLessons.fromLessons(todayLessons),
      ),
    );
  }

  @override
  void onEndLoading() => emit(state.copyWith(isLoading: LoadingStateEnum.ended));
}

class SeparatedLessons {
  const SeparatedLessons({
    required this.passedLessons,
    required this.activeLessons,
    required this.futureLessons,
  });

  factory SeparatedLessons.fromLessons(List<Lesson> lessons) {
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

  const SeparatedLessons.empty() : this(passedLessons: const [], activeLessons: const [], futureLessons: const []);
  final List<Lesson> passedLessons;
  final List<Lesson> activeLessons;
  final List<Lesson> futureLessons;

  bool get isEmpty => passedLessons.isEmpty && activeLessons.isEmpty && futureLessons.isEmpty;
}

@freezed
class TodayScreenState with _$TodayScreenState implements LoadableState {
  const factory TodayScreenState({
    // required List<Lesson> lessonList,
    required SeparatedLessons separatedLessons,
    @Default(LoadingStateEnum.loaded) LoadingStateEnum isLoading,
    @Default(null) String? loadingStateText,
    DialogData? dialogData,
  }) = _MainScreenState;
  const TodayScreenState._();
  factory TodayScreenState.loading() => const TodayScreenState(
        separatedLessons: SeparatedLessons.empty(),
        isLoading: LoadingStateEnum.started,
      );

  @override
  LoadingStateEnum get isStateLoading => isLoading;
}

abstract class DialogData {
  DialogData({required this.title, required this.message});
  String title;
  String message;
}

class ErrorDialogData extends DialogData {
  ErrorDialogData({
    required super.title,
    required super.message,
  });
}

class RequestWorkCountDialogData extends DialogData {
  RequestWorkCountDialogData({
    required super.title,
    required super.message,
    required this.workCount,
  });
  final int workCount;
}
