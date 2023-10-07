// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:queue/models/lesson.dart';
import 'package:queue/presentation/widgets/lesson_widget.dart';

class LessonDatabase {
  final LessonPair _firstPair = const LessonPair(
      TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 10, minute: 30));
  final LessonPair _secondPair = const LessonPair(
      TimeOfDay(hour: 10, minute: 40), TimeOfDay(hour: 12, minute: 10));
  final LessonPair _thirdPair = const LessonPair(
      TimeOfDay(hour: 12, minute: 40), TimeOfDay(hour: 14, minute: 10));
  final LessonPair _fourthPair = const LessonPair(
      TimeOfDay(hour: 14, minute: 20), TimeOfDay(hour: 15, minute: 50));
  final LessonPair _fifthPair = const LessonPair(
      TimeOfDay(hour: 16, minute: 20), TimeOfDay(hour: 17, minute: 50));
  final LessonPair _sixthPair = const LessonPair(
      TimeOfDay(hour: 18, minute: 0), TimeOfDay(hour: 19, minute: 30));
  @Deprecated("For test")
  final LessonPair _testPair = const LessonPair(
      TimeOfDay(hour: 23, minute: 49), TimeOfDay(hour: 23, minute: 58));

  List<Lesson> get todayLessons => lessons
      .where((element) => element.weekDay == DateTime.now().weekday)
      .toList()
    ..sort((a, b) => a.pair.compareTo(b.pair));
  List<Lesson> get lessons => [
        Lesson("АВМ (Архитектура вычислительных машин и систем)", "Авм", 1,
            [true, true], _fifthPair),
        Lesson("Java", "Джава", 4, [true, true], _fourthPair),
        Lesson("Java", "Джава", 4, [true, true], _fifthPair),
        Lesson("Сиаод (Структуры и алгоритмы обработки данных)", "Сиаод", 5,
            [true, true], _fourthPair),
        Lesson("Поис (Предметно-ориентированные информационные системы)",
            "Поис", 5, [true, true], _sixthPair),
        Lesson("Ити (Информационно-технологическая инфраструктура)", "Ити", 6,
            [true, true], _thirdPair),
        Lesson("Test", "test", 6, [true, true], _testPair)
      ];
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
