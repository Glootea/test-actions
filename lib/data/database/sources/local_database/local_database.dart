import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/src/tables.dart';
import 'package:queue/data/database/sources/local_database/src/connection.dart' as impl;
import 'package:queue/entities/src/queue_record.dart';

part 'local_database.g.dart';
part 'package:queue/data/database/sources/local_database/key_value_storage.dart';

@DriftDatabase(tables: [QueueRecs, Subject, Students, WeeklyLessons, DatedLessons, KeyValueStorageTable])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  Future<void> addQueueRecord(QueueRecord queueRecord) async {
    await into(queueRecs).insert(QueueRecsCompanion.insert(
      subjectID: queueRecord.lesson.subjectLocalID,
      studentRowNumber: queueRecord.studentID,
      time: queueRecord.time,
      status: queueRecord.status.toString(),
    ));
  }

  Future<void> deleteQueueRecord(QueueRecord queueRecord) async {
    await (delete(queueRecs)
          ..where((tbl) =>
              tbl.subjectID.equals(queueRecord.lesson.subjectLocalID) &
              tbl.studentRowNumber.equals(queueRecord.studentID)))
        .go();
  }

  Future<void> updateQueueRecordUploadStatus(QueueRecord queueRecord, QueueRecordStatus status) async {
    await into(queueRecs).insert(
        QueueRecsCompanion.insert(
            studentRowNumber: queueRecord.studentID,
            subjectID: queueRecord.lesson.subjectLocalID,
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
