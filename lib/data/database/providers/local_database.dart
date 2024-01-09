import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:queue/data/database/providers/local_database/tables.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';
import 'local_database/connection.dart' as impl;

part 'local_database/local_database.g.dart';
part 'local_database/stored_values_enum.dart';
// ... the TodoItems table definition stays the same

@DriftDatabase(tables: [Recs, Lessons, Students, WeeklyLessons, DatedLessons, UserInfo])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (_, a, b) async {
        if (kDebugMode) {
          // database cleanup on every debug schemaVersion change
          await delete(recs).go();
          await delete(lessons).go();
          await delete(students).go();
          await delete(weeklyLessons).go();
          await delete(datedLessons).go();
          await delete(userInfo).go();
        }
      },
    );
  }

  @override
  int get schemaVersion => 3;
  Future<List<RecEntity>> getRecs(String lessonName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ]))
                ..where(lessons.name.equals(lessonName))
                ..orderBy([OrderingTerm.asc(recs.time)]))
              .get())
          .then((rows) => rows.map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!)).toList());

  @Deprecated('Get from recs list sync')
  Future<RecEntity?> getUserRec(String lessonName, String studentName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ]))
                ..where(lessons.name.equals(lessonName) & students.name.equals(studentName)))
              .getSingle())
          .then((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!));

  Future<List<RecEntity>> getNotUploadedRecs(String userName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id)),
      ])))
            ..where(students.name.equals(userName) & recs.uploaded.equals(false)))
          .get()
          .then((rows) => rows.map((row) => RecEntity(row.read(students.name)!, row.read(recs.time)!, row.read(lessons.name)!)).toList());

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
            ..where(datedLessons.date.day.equals(today.day) & datedLessons.date.month.equals(today.month) & datedLessons.date.year.equals(today.year)))
          .get()
    ]))
        .expand((e) => e)
        .toList();
  }

  Future<bool> createRec(String lessonName, String studentName, DateTime time) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingle().then((student) => student.id);
    int lessonID = await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await into(recs).insert(RecsCompanion(lessonID: Value(lessonID), studentID: Value(studentID), time: Value(time), uploaded: const Value(false)));
    return true;
  }

  Future<void> updateUploadStatus(String lessonName, String studentName, bool status) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingle().then((student) => student.id);
    int lessonID = await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (update(recs)..where((tbl) => tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID))).write(RecsCompanion(uploaded: Value(status)));
  }

  Future<void> deleteRec(String lessonName, String studentName) async {
    int studentID = await (select(students)..where((tbl) => tbl.name.equals(studentName))).getSingle().then((student) => student.id);
    int lessonID = await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (delete(recs)..where((tbl) => tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID))).go();
  }

  Future<void> deleteAllRecs(String lessonName) async {
    int lessonID = await (select(lessons)..where((tbl) => tbl.name.equals(lessonName))).getSingle().then((lesson) => lesson.id);
    await (delete(recs)..where((tbl) => tbl.lessonID.equals(lessonID))).go();
  }

  Future<void> import(List<RecEntity> list) async {
    delete(recs);
    for (final i in list) {
      createRec(i.lessonName, i.userName, i.time);
    }
  }

  //-- user related
  // final _backgroundImageKey = "backgroundImage";
  // final _userNameKey = "userName";
  // final _tableIDKey = 'tableID';
  Future<String?> get(StoredValues key) async {
    return (await (select(userInfo)..where((tbl) => tbl.key.equals(key.toString()))).getSingleOrNull())?.value;
  }

  Future<int> set(StoredValues key, String value) async {
    return into(userInfo).insert(UserInfoCompanion(key: Value(key.toString()), value: Value(value)), mode: InsertMode.insertOrReplace);
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
        : StudentsCompanion(name: newUserName == null ? Value(userName) : Value(newUserName), isAdmin: Value(newIsAdmin)));
  }
  // Future<String?> getBackgroundImage() async {
  //   return (await (select(userInfo)..where((tbl) => tbl.key.equals(_backgroundImageKey))).getSingleOrNull())?.value;
  // }

  Future<void> insertLessons(List<LessonSettingEntity> list, List<String> onlineIds) async {
    int i = 0;
    await Future.wait(list.map((lesson) async {
      int id = await lessons.insertOne(LessonsCompanion(name: Value(lesson.name), onlineID: Value(onlineIds[i])));
      i++;
      if (lesson.useWeekly) {
        await weeklyLessons.insertAll(lesson.weeklyLessons!
            .map((lesson) => lesson.weekdays.map((weekday) => WeeklyLessonsCompanion(
                lessonID: Value(id),
                weekDay: Value(weekday),
                startTime: Value(lesson.startTime.toShortString()),
                endTime: Value(lesson.endTime.toShortString()))))
            .toList()
            .expand((element) => element));
      } else {
        await datedLessons.insertAll(lesson.datedLessons!
            .map((lesson) => lesson.date.map((date) => DatedLessonsCompanion(
                lessonID: Value(id), date: Value(date), startTime: Value(lesson.startTime.toShortString()), endTime: Value(lesson.endTime.toShortString()))))
            .toList()
            .expand((element) => element));
      }
    }).toList());
  }

  Future<void> insertStudents(List<StudentEntity> list) async {
    await students.insertAll(list.map((e) => StudentsCompanion(name: Value(e.name), isAdmin: Value(e.isAdmin))).toList());
  }

  // Future<void> setInfoTableID(String url) async {
  //   // (delete(userInfo)..where((tbl) => tbl.key.equals(_tableIDKey))).go();
  //   into(userInfo).insert(UserInfoCompanion(key: Value(_tableIDKey), value: Value(url)), mode: InsertMode.insertOrReplace);
  // }

  // Future<String?> getInfoTableID() async {
  //   return (await (select(userInfo)..where((tbl) => tbl.key.equals(_tableIDKey))).getSingleOrNull())?.value;
  // }
}
