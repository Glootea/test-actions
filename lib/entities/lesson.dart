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

abstract final class LessonTime {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  const LessonTime(this.startTime, this.endTime);

  LessonTime copyWith({TimeOfDay? startTime, TimeOfDay? endTime});
}

abstract class TimeChooser extends StatefulWidget {
  final int innerCount;
  final void Function(TimeOfDay, TimeOfDay) onTimeChanged;
  final void Function(double) onDeleteButtonPressed;
  const TimeChooser({required this.innerCount, required this.onTimeChanged, required this.onDeleteButtonPressed, super.key});
}

final class WeeklyLessonSettingEntity extends LessonTime {
  final List<int> weekday;
  WeeklyLessonSettingEntity(super.startTime, super.endTime, this.weekday);
  @override
  WeeklyLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<int>? weekday}) {
    return WeeklyLessonSettingEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      weekday ?? this.weekday,
    );
  }
}

final class DatedLessonSettingEntity extends LessonTime {
  final List<DateTime> date;
  DatedLessonSettingEntity(super.startTime, super.endTime, this.date);
  @override
  DatedLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<DateTime>? date}) {
    return DatedLessonSettingEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      date ?? this.date,
    );
  }
}
