import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson__card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson__card_data/queue_data/queue_data.dart';

class LessonCardCubit extends Cubit<LessonCardData> {
  final Lesson _lesson;
  final DatabaseService _databaseService;
  final UserCubit _userCubit;
  LessonCardCubit(this._lesson, this._databaseService, this._userCubit)
      : super(LessonCardData(lesson: _lesson, queueData: null)) {
    fetchQueue();
  }

  Future<void> fetchQueue() async {
    final queue = await _databaseService.getLocalQueueRecordList(_lesson);
    final data = parseQueueRecordList(queue, false);
    emit(state.copyWith(queueData: data));
    final queueOnlineData = await _databaseService.fetchQueueRecordList(_lesson);
    if (queueOnlineData != null) {
      final onlineData = parseQueueRecordList(queue, true);
      emit(state.copyWith(queueData: onlineData));
    }
  }

  Future<void> showQrCode() async {
    // TODO: implement
    final queueRecord = state.queueData!.userRecord;
  }

  Future<void> addQueueRecord() async {
    // TODO: implement
    final lesson = state.lesson;
  }

  Future<void> deleteQueueRecord() async {
    // TODO: implement
    final queueRecord = state.queueData!.userRecord;
  }

  QueueData parseQueueRecordList(List<QueueRecord> queue, bool live) {
    final userRowNumber = _userCubit.rowNumber;
    final userQueueRecord = queue.where((el) => el.studentID == userRowNumber).firstOrNull;
    final queueLength = queue.length;
    int userPosition = queueLength;
    if (userQueueRecord != null) {
      userPosition = queue.indexWhere((el) => el.studentID == userRowNumber);
    }
    return QueueData(
      queueLength: queueLength,
      userPosition: userPosition,
      queueRecordList: queue,
      userRecord: userQueueRecord,
      live: live,
    );
  }
}
