import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';

class DatabaseService {
  DatabaseService({
    required LocalDatabase localDatabase,
    required OnlineDataBase onlineDataBase,
  })  : _localDatabase = localDatabase,
        _onlineDataBase = onlineDataBase;
  final LocalDatabase _localDatabase;
  final OnlineDataBase _onlineDataBase;

  Future<List<Lesson>> todayLessons() async {
    // final date = DateTime.now();
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => [
        Lesson(
          name:
              'АКМС (Анализ и концептуальное моделирование систем)', // startTime MUST be set to microseconds due to attendance
          startTime: DateTime.now().copyWith(hour: 8, minute: 30, second: 0, microsecond: 0, millisecond: 0),
          endTime: DateTime.now().copyWith(hour: 11, minute: 40, second: 0, microsecond: 0, millisecond: 0),
          subjectLocalID: 0,
          subjectOnlineTableID: '4566',
        ),
        Lesson(
          name: 'АКМС (Анализ и концептуальное моделирование систем)',
          startTime: DateTime.now().copyWith(hour: 11, minute: 30, second: 0, microsecond: 0, millisecond: 0),
          endTime: DateTime.now().copyWith(hour: 13, minute: 40, second: 0, microsecond: 0, millisecond: 0),
          subjectLocalID: 0,
          subjectOnlineTableID: '4566',
        ),
        Lesson(
          name: 'АКМС (Анализ и концептуальное моделирование систем)',
          startTime: DateTime.now().copyWith(hour: 13, minute: 30, second: 0, microsecond: 0, millisecond: 0),
          endTime: DateTime.now().copyWith(hour: 16, minute: 40, second: 0, microsecond: 0, millisecond: 0),
          subjectLocalID: 0,
          subjectOnlineTableID: '4566',
        ),
        Lesson(
          name: 'АКМС (Анализ и концептуальное моделирование систем)',
          startTime: DateTime.now().copyWith(hour: 18, minute: 30, second: 0, microsecond: 0, millisecond: 0),
          endTime: DateTime.now().copyWith(hour: 23, minute: 59, second: 0, microsecond: 0, millisecond: 0),
          subjectLocalID: 0,
          subjectOnlineTableID: '4566',
        ),
      ],
    );
    // TODO: implement
  }

  /// {"SubjectName": [List]<[QueueRecord]>}
  Future<List<QueueRecord>?> fetchQueueRecordList(Lesson lesson) async {
    return [];
  }

  Future<List<QueueRecord>> getLocalQueueRecordList(Lesson lesson) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => [
        QueueRecord(
          lesson: lesson,
          studentName: 'Рыбкин Александр',
          studentID: 1,
          time: DateTime.now().subtract(const Duration(days: 1)),
          status: UploadStatus.uploaded,
        ),
        QueueRecord(
          lesson: lesson,
          studentName: 'Лянной Артем',
          studentID: 1,
          time: DateTime.now().subtract(const Duration(days: 2)),
          status: UploadStatus.uploaded,
        ),
        QueueRecord(
          lesson: lesson,
          studentName: 'Софья Бобылева',
          studentID: 1,
          time: DateTime.now().subtract(const Duration(hours: 2)),
          status: UploadStatus.uploaded,
        ),
      ],
    );
  }

  Future<bool> addNewQueueRecord(QueueRecord queueRecord) // TODO: implement
  async {
    final uploaded = await _onlineDataBase.addNewQueueRecord(queueRecord);
    if (uploaded) {
      final updatedQueueRecord = queueRecord.copyWith(status: UploadStatus.uploaded);
      await _localDatabase.addQueueRecord(updatedQueueRecord);
      return true;
    }
    return false;
  }

  Future<void> deleteQueueRecord(QueueRecord queueRecord) async {
    final deleted = await _onlineDataBase.deleteQueueRecord(queueRecord);
    if (deleted) {
      await _localDatabase.deleteQueueRecord(queueRecord);
    } else {
      await _localDatabase.updateQueueRecordUploadStatus(queueRecord, UploadStatus.shouldBeDeleted);
    }
  }

  Lesson getLesson(int subjectLocalID) {
    // TODO: implement getLesson by subjectLocalID
    throw UnimplementedError();
  }

  Future<void> setAttendanded(Lesson lesson) async {
    await _localDatabase.setAttendanded(lesson);
    //TODO: add online upload
  }

  Future<void> removeAttendanded(Lesson lesson) async {
    await _localDatabase.removeAttendanded(lesson);
    //TODO: add online upload
  }

  Future<bool> isAttendanded(Lesson lesson) async {
    return _localDatabase.isAttendanded(lesson);
    //TODO: add online upload
  }
}
