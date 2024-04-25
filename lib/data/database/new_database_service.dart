import 'package:queue/data/database/sources/local_database/new_local_database.dart';
import 'package:queue/data/database/sources/online_database/new_online_database.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';

class NewDatabaseService {
  final NewLocalDatabase _localDatabase;
  final NewOnlineDataBase _onlineDataBase;

  NewDatabaseService({
    required NewLocalDatabase localDatabase,
    required NewOnlineDataBase onlineDataBase,
  })  : _localDatabase = localDatabase,
        _onlineDataBase = onlineDataBase;

  Future<List<NewLesson>> todayLessons() async {
    // final date = DateTime.now();
    // TODO: implement
    throw UnimplementedError();
  }

  /// {"SubjectName": [NewQueueRecord]}
  Future<Map<String, List<NewQueueRecord>>> getQueueRecords(List<String> onlineTableID) // TODO: implement
  {
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
