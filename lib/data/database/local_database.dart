import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'connection.dart' as impl;
import 'package:queue/data/database/tables.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/entities/rec.dart';

part 'local_database.g.dart';
// ... the TodoItems table definition stays the same

@DriftDatabase(
    tables: [Recs, Lessons, Students, WeeklyLessons, DatedLessons, UserInfo])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
  Future<List<RecEntity>> getRecs(String lessonName) => (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id))
      ]))
                ..where(lessons.name.equals(lessonName))
                ..orderBy([OrderingTerm.asc(recs.time)]))
              .get())
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!,
                  row.read(recs.time)!, row.read(lessons.name)!))
              .toList());

  @Deprecated('Get from recs list sync')
  Future<RecEntity?> getUserRec(String lessonName, String studentName) =>
      (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id))
      ]))
                ..where(lessons.name.equals(lessonName) &
                    students.name.equals(studentName)))
              .getSingle())
          .then((row) => RecEntity(row.read(students.name)!,
              row.read(recs.time)!, row.read(lessons.name)!));

  Future<List<RecEntity>> getNotUploadedRecs(String userName) =>
      (((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id))
      ])))
            ..where(
                students.name.equals(userName) & recs.uploaded.equals(false)))
          .get()
          .then((rows) => rows
              .map((row) => RecEntity(row.read(students.name)!,
                  row.read(recs.time)!, row.read(lessons.name)!))
              .toList());

  Future<int> getQueuePlace(String lessonName, String userName) async =>
      (await ((select(recs).join([
        leftOuterJoin(lessons, recs.lessonID.equalsExp(lessons.id)),
        leftOuterJoin(students, recs.studentID.equalsExp(students.id))
      ]))
                ..where(lessons.name.equals(lessonName))
                ..orderBy([OrderingTerm(expression: recs.time)]))
              .get())
          .indexWhere((element) => element.read(students.name) == userName);

  Future<List<LessonEntity>> todayLessons(
      DateTime today, int weekday, String studentName) async {
    final selected = await (select(weeklyLessons)
          ..where((tbl) => tbl.weekDay.equals(weekday)))
        .join([
      leftOuterJoin(lessons, weeklyLessons.lessonID.equalsExp(lessons.id))
    ]).get();
    final result = selected.map((rawRow) async {
      final row = rawRow.rawData.data;
      String lessonName = row['name'];
      List<RecEntity> recs = await getRecs(lessonName);
      RecEntity? studentRec =
          recs.where((element) => element.userName == studentName).firstOrNull;

      TimeOfDay startTime = row['startTime'].toTimeOfDay;
      TimeOfDay endTime = row['endTime'].toTimeOfDay;
      if (studentRec == null) {
        return LessonEntity(lessonName, startTime, endTime, recs);
      } else {
        int position = recs.indexOf(studentRec) + 1;
        return LessonEntity(
            lessonName, startTime, endTime, recs, studentRec, position);
      }
    }).toList();
    final output = <LessonEntity>[];
    for (final r in result) {
      output.add((await r));
    }

    return output;
  }

  Future<void> createRec(
      String lessonName, String studentName, DateTime time) async {
    int studentID = await (select(students)
          ..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);

    int lessonID = await (select(lessons)
          ..where((tbl) => tbl.name.equals(lessonName)))
        .getSingle()
        .then((lesson) => lesson.id);

    into(recs).insert(RecsCompanion(
        lessonID: Value(lessonID),
        studentID: Value(studentID),
        time: Value(time),
        uploaded: const Value(false)));
  }

  Future<void> updateUploadStatus(
      String lessonName, String studentName, bool status) async {
    int studentID = await (select(students)
          ..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);

    int lessonID = await (select(lessons)
          ..where((tbl) => tbl.name.equals(lessonName)))
        .getSingle()
        .then((lesson) => lesson.id);

    (update(recs)
          ..where((tbl) =>
              tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID)))
        .write(RecsCompanion(uploaded: Value(status)));
  }

  Future<void> deleteRec(String lessonName, String studentName) async {
    int studentID = await (select(students)
          ..where((tbl) => tbl.name.equals(studentName)))
        .getSingle()
        .then((student) => student.id);

    int lessonID = await (select(lessons)
          ..where((tbl) => tbl.name.equals(lessonName)))
        .getSingle()
        .then((lesson) => lesson.id);

    (delete(recs)
          ..where((tbl) =>
              tbl.lessonID.equals(lessonID) & tbl.studentID.equals(studentID)))
        .go();
  }

  Future<void> deleteAll(String lessonName) async {
    int lessonID = await (select(lessons)
          ..where((tbl) => tbl.name.equals(lessonName)))
        .getSingle()
        .then((lesson) => lesson.id);

    (delete(recs)..where((tbl) => tbl.lessonID.equals(lessonID))).go();
  }

  Future<void> import(List<RecEntity> list) async {
    delete(recs);
    for (final i in list) {
      createRec(i.lessonName, i.userName, i.time);
    }
  }

  //-- user related
  final _backgroundImageKey = "backgroundImage";
  final _userNameKey = "userName";

  Future<String?> getUserName() async {
    return (await (select(userInfo)
              ..where((tbl) => tbl.key.equals(_userNameKey)))
            .getSingleOrNull())
        ?.value;
  }

  void setUserName(String userName) {
    (update(userInfo)..where((tbl) => tbl.key.equals(_userNameKey))).write(
        UserInfoCompanion(key: Value(_userNameKey), value: Value(userName)));
  }

  void deleteUserName() {
    (delete(userInfo)..where((tbl) => tbl.key.equals(_userNameKey))).go();
  }

  Future<bool> isAdmin(String studentName) async {
    return (await (select(students)
                  ..where((tbl) => tbl.name.equals(studentName)))
                .getSingleOrNull())
            ?.isAdmin ??
        false;
  }

  Future<String?> getBackgroundImage() async {
    return (await (select(userInfo)
              ..where((tbl) => tbl.key.equals(_backgroundImageKey)))
            .getSingle())
        .value;
  }
}
