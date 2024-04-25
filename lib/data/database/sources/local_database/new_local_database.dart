import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/src/tables.dart';
import 'package:queue/data/database/sources/local_database/src/connection.dart' as impl;
import 'package:queue/data/database/sources/local_database/stored_values_enum.dart';
import 'package:queue/entities/src/new_queue_record.dart';
part 'new_local_database.g.dart';

@DriftDatabase(tables: [QueueRecs, Lessons, Students, WeeklyLessons, DatedLessons, KeyValueStorage])
class NewLocalDatabase extends _$NewLocalDatabase {
  NewLocalDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  Future<void> addNewQueueRecord(NewQueueRecord queueRecord) async {
    await into(queueRecs).insert(QueueRecsCompanion.insert(
      subjectID: queueRecord.localSubjectID,
      studentRowNumber: queueRecord.studentRowNumber,
      time: queueRecord.time,
      status: queueRecord.status.toString(),
    ));
  }

  Future<void> deleteQueueRecord(NewQueueRecord queueRecord) async {
    await (delete(queueRecs)
          ..where((tbl) =>
              tbl.subjectID.equals(queueRecord.localSubjectID) &
              tbl.studentRowNumber.equals(queueRecord.studentRowNumber)))
        .go();
  }

  Future<void> updateQueueRecordUploadStatus(NewQueueRecord queueRecord, NewQueueRecordStatus status) async {
    await into(queueRecs).insert(
        QueueRecsCompanion.insert(
            studentRowNumber: queueRecord.studentRowNumber,
            subjectID: queueRecord.localSubjectID,
            time: queueRecord.time,
            status: status.name,
            workCount: Value(queueRecord.workCount ?? 0)),
        mode: InsertMode.insertOrReplace);
  }

  Future<String> get(StoredValues storedValue) async =>
      (await (select(keyValueStorage)..where((tbl) => tbl.key.equals(storedValue.name))).getSingle()).value;

  Future<void> set(StoredValues storedValue, String value) async =>
      await into(keyValueStorage).insert(KeyValueStorageCompanion.insert(
        key: storedValue.name,
        value: value,
      ));

  Future<void> clean(StoredValues storedValue) async =>
      await (delete(keyValueStorage)..where((tbl) => tbl.key.equals(storedValue.name))).go();
}
