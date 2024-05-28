import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/src/tables.dart';
import 'package:queue/data/database/sources/local_database/src/connection.dart' as impl;
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';

part 'local_database.g.dart';
part 'package:queue/data/database/sources/local_database/key_value_storage.dart';

@DriftDatabase(tables: [QueueRecs, Subject, Students, WeeklyLessons, DatedLessons, KeyValueStorageTable, Attendance])
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

  Future<void> updateQueueRecordUploadStatus(QueueRecord queueRecord, UploadStatus status) async {
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

  Future<void> setAttendanded(Lesson lesson) async {
    await into(attendance).insert(AttendanceCompanion.insert(
        subjectID: lesson.subjectLocalID,
        lessonStart: lesson.startTime,
        dateCreated: DateTime.now(),
        status: UploadStatus.shouldBeUploaded.name));
  }

  Future<void> updateAttendanded(Lesson lesson, UploadStatus status) async {
    await (update(attendance)
          ..where((tbl) => tbl.subjectID.equals(lesson.subjectLocalID) & tbl.lessonStart.equals(lesson.startTime)))
        .write(AttendanceCompanion(status: Value(status.name)));
  }

  Future<void> removeAttendanded(Lesson lesson) async {
    await (delete(attendance)
          ..where((tbl) => tbl.subjectID.equals(lesson.subjectLocalID) & tbl.lessonStart.equals(lesson.startTime)))
        .go();
  }

  Future<bool> isAttendanded(Lesson lesson) async {
    final result = await (select(attendance)
          ..where((tbl) => tbl.subjectID.equals(lesson.subjectLocalID) & tbl.lessonStart.equals(lesson.startTime)))
        .getSingleOrNull();
    return result != null;
  }
}
