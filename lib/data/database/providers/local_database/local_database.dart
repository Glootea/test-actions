import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:queue/data/database/providers/local_database/src/tables.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';
import 'src/connection.dart' as impl;

part 'local_database.g.dart';
part 'stored_values_enum.dart';

@DriftDatabase(tables: [Recs, Lessons, Students, WeeklyLessons, DatedLessons, UserInfo])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 2;
  Future<List<RecEntity>> getRecs(String lessonName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ]))
                ..where(lessons.name.equals(lessonName) & recs.uploaded.isNotValue(-1))
                ..orderBy([OrderingTerm.asc(recs.time)]))
              .get())
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!,
                  (row.read(recs.uploaded) == 1)))
              .toList());

  Future<List<RecEntity>> getNotUploadedRecs(String userName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ])))
            ..where(students.name.equals(userName) & recs.uploaded.equals(0)))
          .get()
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!))
              .toList());

  Future<List<RecEntity>> getNotDeletedRecs(String userName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ])))
            ..where(students.name.equals(userName) & recs.uploaded.equals(-1)))
          .get()
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!))
              .toList());

  Future<int> getQueuePlace(String lessonName, String userName) async => (await ((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ]))
                ..where(lessons.name.equals(lessonName))
                ..orderBy([OrderingTerm(expression: recs.time)]))
              .get())
          .indexWhere((element) => element.read(students.name) == userName);

  Future<List<LessonEntity>> todayLessons(DateTime today, String studentName) async {
    final weekday = today.weekday;
    final selected = await _selectTodayLessons(weekday, today);
    final result = selected.map((rawRow) {
      return _mapTypedResultToLessonEntity(rawRow, studentName);
    }).toList();
    final output = await Future.wait(result);
    return output;
  }

  Future<LessonEntity> _mapTypedResultToLessonEntity(TypedResult rawRow, String studentName) async {
    final Map row = rawRow.rawData.data.map((key, value) => MapEntry(key.split('.').last, value));
    final lessonName = row['name']!;
    final recs = await getRecs(lessonName);
    final studentRec = recs.where((element) => element.userName == studentName).firstOrNull;
    final startTime = (row['start_time']! as String).toTimeOfDay;
    final endTime = (row['end_time']! as String).toTimeOfDay;
    if (studentRec == null) {
      return LessonEntity(lessonName, startTime, endTime, recs);
    } else {
      final queuePosition = recs.indexOf(studentRec) + 1;
      return LessonEntity(lessonName, startTime, endTime, recs, studentRec, queuePosition);
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

  Future<bool> createRec(String lessonName, String studentName, DateTime time, {int? uploaded}) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await into(recs).insert(
        RecsCompanion(
            lessonID: Value(lessonID), studentID: Value(studentID), time: Value(time), uploaded: Value(uploaded ?? 0)),
        mode: InsertMode.insertOrReplace);
    return true;
  }

  /// Status: 1 - uploaded; 0 - not uploaded, but should be; -1 - should be deleted
  Future<void> updateUploadStatus(String lessonName, String studentName, int status) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);
    int lessonID =
        await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (update(recs)..where((tbl) => tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID)))
        .write(RecsCompanion(uploaded: Value(status)));
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
    await Future.wait(list.map((i) async => createRec(i.lessonName, i.userName, i.time, uploaded: 1)));
  }

  //-- user related
  // final _backgroundImageKey = "backgroundImage";
  // final _userNameKey = "userName";
  // final _tableIDKey = 'tableID';
  Future<String?> get(StoredValues key) async {
    return (await (select(userInfo)..where((tbl) => tbl.key.equals(key.toString()))).getSingleOrNull())?.value;
  }

  Future<int> set(StoredValues key, String value) async {
    return into(userInfo)
        .insert(UserInfoCompanion(key: Value(key.toString()), value: Value(value)), mode: InsertMode.insertOrReplace);
  }

  Future<int> clean(StoredValues key) async {
    return (delete(userInfo)..where((tbl) => tbl.key.equals(key.toString()))).go();
  }
  // Future<String?> getUserName() async {
  //   return (await (select(userInfo)..where((tbl) => tbl.key.equals(_userNameKey))).getSingleOrNull())?.value;
  // }

  // void setUserName(String userName) {
  //   into(userInfo).insert(UserInfoCompanion(key: Value(_userNameKey), value: Value(userName)), mode: InsertMode.insertOrReplace);
  // }

  // void deleteUserName() {
  //   (delete(userInfo)..where((tbl) => tbl.key.equals(_userNameKey))).go();
  // }

  Future<bool> isAdmin(String studentName) async {
    return (await (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingleOrNull())?.isAdmin ?? false;
  }

  Future<int> updateStudent(String userName, {String? newUserName, bool? newIsAdmin}) {
    return (update(students)..where((tbl) => tbl.name.equals(userName))).write(newIsAdmin == null
        ? StudentsCompanion(name: newUserName == null ? Value(userName) : Value(newUserName))
        : StudentsCompanion(
            name: newUserName == null ? Value(userName) : Value(newUserName), isAdmin: Value(newIsAdmin)));
  }
  // Future<String?> getBackgroundImage() async {
  //   return (await (select(userInfo)..where((tbl) => tbl.key.equals(_backgroundImageKey))).getSingleOrNull())?.value;
  // }

  Future<void> insertLessons(List<LessonSettingEntity> list, List<String> onlineIds) async {
    await Future.wait(list.map((lesson) async {
      int id = await lessons
          .insertOne(LessonsCompanion(name: Value(lesson.name), onlineID: Value(onlineIds[list.indexOf(lesson)])));
      List<WeeklyLessonSettingEntity> weeklyLessonList =
          lesson.lessonTimes.whereType<WeeklyLessonSettingEntity>().toList();
      List<DatedLessonSettingEntity> datedLessonsList =
          lesson.lessonTimes.whereType<DatedLessonSettingEntity>().toList();
      await weeklyLessons.insertAll(
          weeklyLessonList
              .map((lesson) => lesson.weekdays.map((weekday) => WeeklyLessonsCompanion(
                  lessonID: Value(id),
                  weekDay: Value(weekday),
                  startTime: Value(lesson.startTime.toShortString),
                  endTime: Value(lesson.endTime.toShortString))))
              .toList()
              .expand((element) => element),
          mode: InsertMode.insertOrReplace);

      await datedLessons.insertAll(
          datedLessonsList
              .map((lesson) => lesson.date.map((date) => DatedLessonsCompanion(
                  lessonID: Value(id),
                  date: Value(date),
                  startTime: Value(lesson.startTime.toShortString),
                  endTime: Value(lesson.endTime.toShortString))))
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

  Future<void> clearAll() async {
    await delete(recs).go();
    await delete(lessons).go();
    await delete(students).go();
    await delete(weeklyLessons).go();
    await delete(datedLessons).go();
    await delete(userInfo).go();
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
