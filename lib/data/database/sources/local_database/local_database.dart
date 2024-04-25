import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:queue/data/database/sources/local_database/src/tables.dart';
import 'package:queue/data/database/sources/local_database/stored_values_enum.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';
import 'package:queue/data/database/sources/local_database/src/connection.dart' as impl;

part 'local_database.g.dart';

@DriftDatabase(tables: [Recs, Lessons, Students, WeeklyLessons, DatedLessons, KeyValueStorage])
@Deprecated("Switch to new version")
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 2;
  Future<List<RecEntity>> getrecs(String lessonName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.rowNumber)),
      ]))
                ..where(lessons.name.equals(lessonName) & recs.uploaded.isNotValue(-1))
                ..orderBy([OrderingTerm.asc(recs.time)]))
              .get())
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!,
                  isUploaded: (row.read(recs.uploaded) == 1), workCount: row.read(recs.workCount)))
              .toList());

  Future<List<RecEntity>> getNotUploadedRecs(String userName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.rowNumber)),
      ])))
            ..where(students.name.equals(userName) & recs.uploaded.equals(0)))
          .get()
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!,
                  workCount: row.read(recs.workCount)))
              .toList());

  Future<List<RecEntity>> getNotDeletedRecs(String userName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.rowNumber)),
      ])))
            ..where(students.name.equals(userName) & recs.uploaded.equals(-1)))
          .get()
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!,
                  workCount: row.read(recs.workCount)))
              .toList());

  Future<int> getQueuePlace(String lessonName, String userName) async => (await ((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.rowNumber)),
      ]))
                ..where(lessons.name.equals(lessonName))
                ..orderBy([OrderingTerm(expression: recs.time)]))
              .get())
          .indexWhere((element) => element.read(students.name) == userName);

  Future<List<LessonDisplayedEntity>> todayLessons(DateTime today, String studentName) async {
    final weekday = today.weekday;
    final selected = await _selectTodayLessons(weekday, today);
    final result = selected.map((rawRow) {
      return _mapTypedResultToLessonEntity(rawRow, studentName);
    }).toList();
    final output = await Future.wait(result);
    return output;
  }

  Future<LessonDisplayedEntity> _mapTypedResultToLessonEntity(TypedResult rawRow, String studentName) async {
    final Map row = rawRow.rawData.data.map((key, value) => MapEntry(key.split('.').last, value));
    final lessonName = row['name']!;
    final recs = await getrecs(lessonName);
    final studentRec = recs.where((element) => element.userName == studentName).firstOrNull;
    final startTime = (row['start_time']! as String).toTimeOfDay;
    final endTime = (row['end_time']! as String).toTimeOfDay;
    final useWorkCount = (row['use_work_count']! as int) == 1;
    if (studentRec == null) {
      return LessonDisplayedEntity(lessonName, startTime, endTime, recs, useWorkCount);
    } else {
      final queuePosition = recs.indexOf(studentRec) + 1;
      return LessonDisplayedEntity(lessonName, startTime, endTime, recs, useWorkCount, studentRec, queuePosition);
    }
  }

  Future<List<TypedResult>> _selectTodayLessons(int weekday, DateTime today) async {
    final lessonSelection = select(lessons);
    return (await Future.wait([
      (lessonSelection.join([
        leftOuterJoin(weeklyLessons, lessons.id.equalsExp(weeklyLessons.lessonID)),
      ])
            ..where(weeklyLessons.weekDay.equals(weekday)))
          .get(),
      (lessonSelection.join([leftOuterJoin(datedLessons, lessons.id.equalsExp(datedLessons.lessonID))])
            ..where(datedLessons.date.day.equals(today.day) &
                datedLessons.date.month.equals(today.month) &
                datedLessons.date.year.equals(today.year)))
          .get()
    ]))
        .expand((e) => e)
        .toList();
  }

  Future<bool> createRec(String lessonName, String studentName, DateTime time, {int? uploaded, int? workCount}) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await into(recs).insert(
        RecsCompanion(
            lessonID: Value(lessonID),
            studentID: Value(studentID),
            time: Value(time),
            uploaded: Value(uploaded ?? 0),
            workCount: Value(workCount)),
        mode: InsertMode.insertOrReplace);
    return true;
  }

  /// Status: 1 - uploaded; 0 - not uploaded, but should be; -1 - should be deleted
  Future<void> updateUploadStatus(String lessonName, String studentName, int status, {int? workCount}) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (update(recs)..where((tbl) => tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID)))
        .write(RecsCompanion(uploaded: Value(status), workCount: Value(workCount)));
  }

  Future<void> deleteRec(String lessonName, String studentName) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (delete(recs)..where((tbl) => tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID))).go();
  }

  Future<void> deleteAllRecs(String lessonName) async {
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (delete(recs)..where((tbl) => tbl.lessonID.equals(lessonID))).go();
  }

  Future<void> import(List<RecEntity> list) async {
    await Future.wait(
        list.map((i) async => createRec(i.lessonName, i.userName, i.time, uploaded: 1, workCount: i.workCount)));
  }

  Future<String?> get(StoredValues key) async {
    return (await (select(keyValueStorage)..where((tbl) => tbl.key.equals(key.toString()))).getSingleOrNull())?.value;
  }

  Future<int> set(StoredValues key, String value) async {
    return into(keyValueStorage).insert(KeyValueStorageCompanion(key: Value(key.toString()), value: Value(value)),
        mode: InsertMode.insertOrReplace);
  }

  Future<int> clean(StoredValues key) async {
    return (delete(keyValueStorage)..where((tbl) => tbl.key.equals(key.toString()))).go();
  }

  Future<bool> isAdmin(String studentName) async {
    return (await (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingleOrNull())?.isAdmin ?? false;
  }

  Future<int> updateStudent(String userName, {String? newUserName, bool? newIsAdmin}) {
    return (update(students)..where((tbl) => tbl.name.equals(userName))).write(newIsAdmin == null
        ? StudentsCompanion(name: newUserName == null ? Value(userName) : Value(newUserName))
        : StudentsCompanion(
            name: newUserName == null ? Value(userName) : Value(newUserName), isAdmin: Value(newIsAdmin)));
  }

  Future<void> insertLessons(List<LessonEntity> list, List<String> onlineIds) async {
    await Future.wait(list.map((lesson) async {
      int id = await lessons.insertOne(LessonsCompanion(
          name: Value(lesson.name),
          onlineID: Value(onlineIds[list.indexOf(lesson)]),
          autoDelete: Value(lesson.autoDelete),
          useWorkCount: Value(lesson.useWorkCount)));
      List<WeeklyLessonEntity> weeklyLessonList = lesson.lessonTimes.whereType<WeeklyLessonEntity>().toList();
      List<DatedLessonEntity> datedLessonsList = lesson.lessonTimes.whereType<DatedLessonEntity>().toList();
      await weeklyLessons.insertAll(
          weeklyLessonList
              .map((lesson) => lesson.weekdays.map((weekday) => WeeklyLessonsCompanion(
                  lessonID: Value(id),
                  weekDay: Value(weekday),
                  startTime: Value(lesson.startTime.toOnlineString),
                  endTime: Value(lesson.endTime.toOnlineString))))
              .toList()
              .expand((element) => element),
          mode: InsertMode.insertOrReplace);

      await datedLessons.insertAll(
          datedLessonsList
              .map((lesson) => lesson.date.map((date) => DatedLessonsCompanion(
                  lessonID: Value(id),
                  date: Value(date),
                  startTime: Value(lesson.startTime.toOnlineString),
                  endTime: Value(lesson.endTime.toOnlineString))))
              .toList()
              .expand((element) => element),
          mode: InsertMode.insertOrReplace);
    }).toList());
  }

  Future<List<String>> getLessonNames() async {
    return (select(lessons)).get().then((value) => value.map((e) => e.name).toList());
  }

  Future<String> getLessonTableID(String lessonName) async {
    return (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((value) => value.onlineID);
  }

  Future<void> insertStudents(List<StudentEntity> list) async {
    await students.insertAll(
        list
            .map((e) =>
                StudentsCompanion(name: Value(e.name), isAdmin: Value(e.isAdmin), id: Value(e.onlineTableRowNumber)))
            .toList(),
        mode: InsertMode.insertOrReplace);
  }

  Future<List<StudentEntity>> getStudents() async {
    return (select(students))
        .get()
        .then((value) => value.map((e) => StudentEntity(e.name, e.id, isAdmin: e.isAdmin ?? false)).toList());
  }

  Future<int> getOnlineTableRowNumber(String studentName) async {
    return (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingle().then((value) => value.id);
  }

  Future<void> deleteQueue(String lessonName, DateTime lastDelete) async {
    await Future.wait([
      (update(lessons)..where((tbl) => tbl.name.equals(lessonName)))
          .write(LessonsCompanion(lastDelete: Value(lastDelete))),
      deleteAllRecs(lessonName)
    ]);
  }

  Future<List<String>> getOnlineIDsOfLessonsToDeleteQueue() async {
    return (select(lessons)..where((tbl) => tbl.autoDelete.equals(true)))
        .get()
        .then((value) => value.map((e) => e.onlineID).toList());
  }

  Future<DateTime?> getLastLessonTime(String onlineID) async {
    final today = DateTime.now();
    final daysBefore = await Future.wait(List.generate(
        7,
        (index) => todayLessons(today.subtract(Duration(days: index + 1)), '')
            .then((value) => value.isNotEmpty ? index + 1 : null)));
    daysBefore.sort();
    return daysBefore.first != null ? today.subtract(Duration(days: daysBefore.first!)) : null;
  }

  Future<void> clearAll() async {
    await delete(recs).go();
    await delete(lessons).go();
    await delete(students).go();
    await delete(weeklyLessons).go();
    await delete(datedLessons).go();
    await delete(keyValueStorage).go();
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (_, a, b) async {
        if (kDebugMode) {
          // database cleanup on every debug schemaVersion change
          clearAll();
        }
      },
    );
  }
}
