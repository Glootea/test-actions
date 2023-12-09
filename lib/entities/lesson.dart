import 'package:flutter/material.dart';
import 'package:queue/entities/rec.dart';

///To be displayed
final class LessonEntity {
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<RecEntity> recs;
  final RecEntity? userRec;
  final int? userQueuePosition;
  LessonEntity(this.name, this.startTime, this.endTime, this.recs, [this.userRec, this.userQueuePosition]);
}

/// Used in settings menu
final class LessonSettingEntity {
  final String name;
  final LessonEntity? weeklyLesson;
  final List<WeeklyLessonSettingEntity>? datedLessons;
  final bool useWeekly;
  LessonSettingEntity(this.name, {this.weeklyLesson, this.datedLessons, this.useWeekly = true});

  LessonSettingEntity copyWith({String? name, LessonEntity? weeklyLesson, List<WeeklyLessonSettingEntity>? datedLessons, bool? useWeekly}) {
    return LessonSettingEntity(name ?? this.name,
        weeklyLesson: weeklyLesson ?? this.weeklyLesson, datedLessons: datedLessons ?? this.datedLessons, useWeekly: useWeekly ?? this.useWeekly);
  }
}

final class WeeklyLessonSettingEntity {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> weekday;
  WeeklyLessonSettingEntity(this.startTime, this.endTime, this.weekday);
  WeeklyLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<int>? weekday}) {
    return WeeklyLessonSettingEntity(
      startTime ?? this.startTime,
      endTime ?? this.endTime,
      weekday ?? this.weekday,
    );
  }
}

final class DatedLessonSettingEntity {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<DateTime> date;
  DatedLessonSettingEntity(this.startTime, this.endTime, this.date);
  DatedLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<DateTime>? date}) {
    return DatedLessonSettingEntity(
      startTime ?? this.startTime,
      endTime ?? this.endTime,
      date ?? this.date,
    );
  }
}
