// ignore_for_file: unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:queue/extension.dart';
import 'package:queue/models/lesson.dart';
import 'package:queue/models/rec.dart';

LessonPair _firstPair = const LessonPair(
    TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 10, minute: 30));
LessonPair _secondPair = const LessonPair(
    TimeOfDay(hour: 10, minute: 40), TimeOfDay(hour: 12, minute: 10));
LessonPair _thirdPair = const LessonPair(
    TimeOfDay(hour: 12, minute: 40), TimeOfDay(hour: 14, minute: 10));
LessonPair _fourthPair = const LessonPair(
    TimeOfDay(hour: 14, minute: 20), TimeOfDay(hour: 15, minute: 50));
LessonPair _fifthPair = const LessonPair(
    TimeOfDay(hour: 16, minute: 20), TimeOfDay(hour: 17, minute: 50));
LessonPair _sixthPair = const LessonPair(
    TimeOfDay(hour: 18, minute: 0), TimeOfDay(hour: 19, minute: 30));
@Deprecated("For test")
LessonPair _testPair = const LessonPair(
    TimeOfDay(hour: 8, minute: 00), TimeOfDay(hour: 23, minute: 50));

class LessonDatabase {
  final FlutterSecureStorage secureStorage;
  LessonDatabase._(this.lessons, this.secureStorage);

  static Future<LessonDatabase> fillFromLocal(String userName) async {
    List<Lesson> blankLessons = [
      Lesson("АВМ (Архитектура вычислительных машин и систем)", "Авм", 1,
          [true, true], _fifthPair),
      Lesson("Java", "Джава", 4, [true, true], _fourthPair),
      Lesson("Java", "Джава", 4, [true, true], _fifthPair),
      Lesson("Сиаод (Структуры и алгоритмы обработки данных)", "Сиаод", 5,
          [true, true], _fourthPair),
      Lesson("Поис (Предметно-ориентированные информационные системы)", "Поис",
          5, [true, true], _sixthPair),
      Lesson("Ити (Информационно-технологическая инфраструктура)", "Ити", 6,
          [true, true], _thirdPair),
      Lesson(
        "Test (long test name to test how it fits)",
        "test",
        3,
        [true, true],
        _testPair,
      )
    ];
    const storage = FlutterSecureStorage();
    for (var lesson in blankLessons) {
      String lessonName = lesson.tableName;
      String key = _getKeyStatic(lessonName, userName);
      String? data = await storage.read(key: key);
      if (data != null) {
        UserRec userRec = UserRec.fromString(data, userName);
        blankLessons
            .where((element) => element.tableName == lessonName)
            .first
            .userRec = userRec;
      }
    }
    return LessonDatabase._(blankLessons, storage);
  }

  final List<Lesson> lessons;
  List<Lesson> get todayLessons => lessons
      .where((element) => element.weekDay == DateTime.now().weekday)
      .toList()
    ..sort((a, b) => a.pair.compareTo(b.pair));

  void createRec(
      String lessonName, String userName, bool isOnline, DateTime time) {
    lessons.where((element) => element.tableName == lessonName).first.userRec =
        UserRec(userName, time, isOnline);
    lessons
        .where((element) => element.tableName == lessonName)
        .first
        .recs
        .add(UserRec(userName, time, isOnline));
    _writeToStorage(lessonName, userName, isOnline, time);
  }

  void updateRec(
      String lessonName, String userName, bool isOnline, DateTime time) {
    try {
      lessons
          .where((element) => element.tableName == lessonName)
          .first
          .userRec = UserRec(userName, time, isOnline);
      int index = lessons
          .where((element) => element.tableName == lessonName)
          .first
          .recs
          .indexWhere((element) => element.userName == userName);
      lessons
          .where((element) => element.tableName == lessonName)
          .first
          .recs[index] = UserRec(userName, time, isOnline);
      _writeToStorage(lessonName, userName, isOnline, time);
    } catch (e) {
      log("$e\nNot found element to update. Not critical");
    }
  }

  void deleteReg(String lessonName, String userName) {
    try {
      lessons
          .where((element) => element.tableName == lessonName)
          .first
          .userRec = null;
      int index = lessons
          .where((element) => element.tableName == lessonName)
          .first
          .recs
          .indexWhere((element) => element.userName == userName);
      if (index < 0) throw RangeError('Value not in range: -1');
      lessons
          .where((element) => element.tableName == lessonName)
          .first
          .recs
          .removeAt(index);
      _deleteFromStorage(lessonName, userName);
    } catch (e) {
      log("$e\nNot found element to delete. Not critical");
    }
  }

  String _getKey(String lessonName, String userName) =>
      "$lessonName${userName}UserRec";
  static String _getKeyStatic(String lessonName, String userName) =>
      "$lessonName${userName}UserRec";
  Future<void> _writeToStorage(
      String lessonName, String userName, bool isOnline, DateTime time) async {
    await secureStorage.write(
        key: _getKey(lessonName, userName),
        value: "${time.toIso8601String()},$isOnline");
  }

  void import(String lessonName, List<Rec> recs, String userName) {
    int lessonIndex =
        lessons.indexWhere((element) => element.tableName == lessonName);
    lessons[lessonIndex].recs = recs;
    int userRecIndex =
        recs.indexWhere((element) => element.userName == userName);
    if (userRecIndex != -1) {
      Rec rec = recs[userRecIndex];
      lessons[lessonIndex].userRec = UserRec(userName, rec.time, true);
      _writeToStorage(
          lessonName, userName, true, lessons[lessonIndex].userRec!.time);
    } else {
      lessons[lessonIndex].userRec = null;
      _deleteFromStorage(lessonName, userName);
    }
    // try {
    //   UserRec userRec = (recs
    //       .where((element) => element.userName == userName)
    //       .first as UserRec);
    //   lessons[lessonIndex].userRec = userRec;
    // } catch (e) {
    //   log("No user reg found. Normal");
    // }
  }

  Future<void> _deleteFromStorage(
    String lessonName,
    String userName,
  ) async {
    await secureStorage.delete(
      key: _getKey(lessonName, userName),
    );
  }
}

class LessonPair {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  int compareTo(LessonPair other) {
    return (startTime < other.startTime)
        ? -1
        : (startTime == other.startTime)
            ? 0
            : 1;
  }

  const LessonPair(this.startTime, this.endTime);
}
