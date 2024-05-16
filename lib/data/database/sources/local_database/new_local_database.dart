import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/src/tables.dart';
import 'package:queue/data/database/sources/local_database/src/connection.dart' as impl;
import 'package:queue/entities/src/new_queue_record.dart';

part 'new_local_database.g.dart';
part 'package:queue/data/database/sources/local_database/key_value_storage.dart';

@DriftDatabase(tables: [QueueRecs, Subject, Students, WeeklyLessons, DatedLessons, KeyValueStorageTable])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());

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

  Future<void> updateQueueRecordUploadStatus(NewQueueRecord queueRecord, QueueRecordStatus status) async {
    await into(queueRecs).insert(
        QueueRecsCompanion.insert(
            studentRowNumber: queueRecord.studentRowNumber,
            subjectID: queueRecord.localSubjectID,
            time: queueRecord.time,
            status: status.name,
            workCount: Value(queueRecord.workCount ?? 0)),
        mode: InsertMode.insertOrReplace);
  }

  Future<String?> _get(StoredValues storedValue) async =>
      (await (select(keyValueStorageTable)..where((tbl) => tbl.key.equals(storedValue.name))).getSingleOrNull())?.value;

  Future<void> _set(StoredValues storedValue, String value) async => await into(keyValueStorageTable).insert(
      KeyValueStorageTableCompanion.insert(
        key: storedValue.name,
        value: value,
      ),
      mode: InsertMode.insertOrReplace);

  Future<void> _clean(StoredValues storedValue) async =>
      await (delete(keyValueStorageTable)..where((tbl) => tbl.key.equals(storedValue.name))).go();
}
