import 'package:queue/data/database/sources/local_database/new_local_database.dart';
import 'package:queue/data/database/sources/online_database/new_online_database.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';

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
                startTime: DateTime(2024, 5, 2, 15, 30),
                endTime: DateTime(2024, 5, 2, 17, 30),
                subjectLocalID: 0,
                subjectOnlineTableID: '4566',
              )
            ]);
    // TODO: implement
    throw UnimplementedError();
  }

  /// {"SubjectName": [List]<[NewQueueRecord]>}
  Future<Map<String, List<NewQueueRecord>>> getQueueRecords(List<String> onlineTableID) // TODO: implement
  async {
    return {
      "АКМС (Анализ и концептуальное моделирование систем)": [
        NewQueueRecord(
            localSubjectID: 0,
            onlineTableID: '4566',
            status: NewQueueRecordStatus.uploaded,
            studentRowNumber: 1,
            workCount: 3,
            time: DateTime(2024, 4, 28, 14, 16))
      ]
    };
    return {};
    throw UnimplementedError();
  }

  Future<bool> addNewQueueRecord(NewQueueRecord queueRecord, int rowNumber) // TODO: implement
  async {
    final uploaded = await _onlineDataBase.addNewQueueRecord(queueRecord);
    if (uploaded) {
      queueRecord = queueRecord.copyWith(status: NewQueueRecordStatus.uploaded);
      await _localDatabase.addNewQueueRecord(queueRecord);
      return true;
    }
    return false;
  }

  Future<void> deleteQueueRecord(NewQueueRecord queueRecord) async {
    final deleted = await _onlineDataBase.deleteQueueRecord(queueRecord);
    if (deleted) {
      _localDatabase.deleteQueueRecord(queueRecord);
    } else {
      await _localDatabase.updateQueueRecordUploadStatus(queueRecord, NewQueueRecordStatus.shouldBeDeleted);
    }
  }
}
