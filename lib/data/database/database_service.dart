import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';

class DatabaseService {
  final LocalDatabase _localDatabase;
  final OnlineDataBase _onlineDataBase;

  DatabaseService({
    required LocalDatabase localDatabase,
    required OnlineDataBase onlineDataBase,
  })  : _localDatabase = localDatabase,
        _onlineDataBase = onlineDataBase;

  Future<List<Lesson>> todayLessons() async {
    // final date = DateTime.now();
    return Future.delayed(
        const Duration(milliseconds: 100),
        () => [
              Lesson(
                name: "АКМС (Анализ и концептуальное моделирование систем)",
                startTime: DateTime(2024, 5, 9, 12, 30),
                endTime: DateTime(2024, 5, 9, 12, 40),
                subjectLocalID: 0,
                subjectOnlineTableID: '4566',
              ),
              Lesson(
                name: "АКМС (Анализ и концептуальное моделирование систем)",
                startTime: DateTime(2024, 5, 9, 12, 30),
                endTime: DateTime(2024, 5, 9, 12, 40),
                subjectLocalID: 0,
                subjectOnlineTableID: '4566',
              ),
              Lesson(
                name: "АКМС (Анализ и концептуальное моделирование систем)",
                startTime: DateTime(2024, 5, 9, 15, 30),
                endTime: DateTime(2024, 5, 9, 16, 40),
                subjectLocalID: 0,
                subjectOnlineTableID: '4566',
              ),
              Lesson(
                name: "АКМС (Анализ и концептуальное моделирование систем)",
                startTime: DateTime(2024, 5, 9, 18, 30),
                endTime: DateTime(2024, 5, 9, 19, 40),
                subjectLocalID: 0,
                subjectOnlineTableID: '4566',
              ),
            ]);
    // TODO: implement
    throw UnimplementedError();
  }

  /// {"SubjectName": [List]<[QueueRecord]>}
  Future<Map<String, List<QueueRecord>>> getQueueRecords(List<String> onlineTableID) // TODO: implement
  async {
    // return {
    //   "АКМС (Анализ и концептуальное моделирование систем)": [
    //    QueueRecord(
    //         localSubjectID: 0,
    //         onlineTableID: '4566',
    //         status: NewQueueRecordStatus.uploaded,
    //         studentRowNumber: 1,
    //         workCount: 3,
    //         time: DateTime(2024, 4, 28, 14, 16))
    //   ]
    // };
    return {};
    throw UnimplementedError();
  }

  Future<bool> addNewQueueRecord(QueueRecord queueRecord) // TODO: implement
  async {
    final uploaded = await _onlineDataBase.addNewQueueRecord(queueRecord);
    if (uploaded) {
      queueRecord = queueRecord.copyWith(status: QueueRecordStatus.uploaded);
      await _localDatabase.addQueueRecord(queueRecord);
      return true;
    }
    return false;
  }

  Future<void> deleteQueueRecord(QueueRecord queueRecord) async {
    final deleted = await _onlineDataBase.deleteQueueRecord(queueRecord);
    if (deleted) {
      _localDatabase.deleteQueueRecord(queueRecord);
    } else {
      await _localDatabase.updateQueueRecordUploadStatus(queueRecord, QueueRecordStatus.shouldBeDeleted);
    }
  }

  Lesson getLesson(int subjectLocalID) {
    // TODO: implement getLesson by subjectLocalID
    throw UnimplementedError();
  }
}
