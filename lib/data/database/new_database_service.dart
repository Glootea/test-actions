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
                  name: "АКМС (Академическое моделирование систем)",
                  startTime: DateTime(2024, 4, 28, 14, 20),
                  endTime: DateTime(2024, 4, 28, 10, 50),
                  subjectLocalID: 0,
                  subjectOnlineTableID: '4566',
                  recList: [])
            ]);
    // TODO: implement
    throw UnimplementedError();
  }

  /// {"SubjectName": [NewQueueRecord]}
  Future<Map<String, List<NewQueueRecord>>> getQueueRecords(List<String> onlineTableID) // TODO: implement
  async {
    return <String, List<NewQueueRecord>>{};
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
