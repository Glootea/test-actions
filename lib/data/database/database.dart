import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:queue/data/database/tables.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/entities/rec.dart';
import 'package:queue/extension.dart';
part 'database.g.dart';

@DriftDatabase(tables: [Recs, Lessons, Students, DatedLessons])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase._(QueryExecutor e) : super(e);

  factory LocalDatabase() => LocalDatabase._(_connectOnWeb());
  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) async {
        await m.createAll();
        await customStatement('PRAGMA foreign_keys = ON');
        into(lessons).insert(const Lesson(
            id: 0,
            name: "Sunday pair",
            startTime: "17:30",
            endTime: "22:50",
            weekDay: 7));
        into(students).insert(
            const Student(id: 0, name: "Рыбкин Александр Владимирович"));
        into(students).insert(const Student(id: 1, name: "Dasha Vas"));
        into(recs).insert(Rec(
            id: 0,
            studentID: 0,
            lessonID: 0,
            time: DateTime(2023, 11, 5, 17, 16, 43, 54),
            uploaded: false));
        into(recs).insert(Rec(
            id: 1,
            studentID: 1,
            lessonID: 0,
            time: DateTime(2023, 11, 5, 17, 16)));
      });
  @override
  int get schemaVersion => 1;

  ///Sorted by time list
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
    final selected = await (select(lessons)
          ..where((tbl) => tbl.weekDay.equals(weekday)))
        .get();
    final result = selected.map((row) async {
      String lessonName = row.name;
      List<RecEntity> recs = await getRecs(lessonName);
      RecEntity? studentRec =
          recs.where((element) => element.userName == studentName).firstOrNull;
      String name = row.name;
      TimeOfDay startTime = row.startTime.toTimeOfDay;
      TimeOfDay endTime = row.endTime.toTimeOfDay;
      if (studentRec == null) {
        return LessonEntity(name, startTime, endTime, recs);
      } else {
        int position = recs.indexOf(studentRec) + 1;
        return LessonEntity(
            name, startTime, endTime, recs, studentRec, position);
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

  // Future<void> createLesson(String displayName, )
}

DatabaseConnection _connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'student_queue',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    if (result.missingFeatures.isNotEmpty) {
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}
