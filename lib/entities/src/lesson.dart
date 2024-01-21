import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:queue/entities/export.dart';

///To be displayed
@immutable
final class LessonEntity extends Equatable implements Comparable {
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<RecEntity> recs;
  final RecEntity? userRec;
  final int? userQueuePosition;
  const LessonEntity(this.name, this.startTime, this.endTime, this.recs, [this.userRec, this.userQueuePosition]);
  LessonEntity copyWith({String? name, TimeOfDay? startTime, TimeOfDay? endTime, List<RecEntity>? recs, RecEntity? userRec, int? userQueuePosition}) {
    return LessonEntity(name ?? this.name, startTime ?? this.startTime, endTime ?? this.endTime, recs ?? this.recs, userRec ?? this.userRec,
        userQueuePosition ?? this.userQueuePosition);
  }

  LessonEntity copyWithoutUserRec() {
    return LessonEntity(name, startTime, endTime, recs);
  }

  @override
  int compareTo(other) {
    if (other is LessonEntity) {
      if (startTime == other.startTime) {
        return 0;
      } else if (startTime.hour * 60 + startTime.minute < other.startTime.hour * 60 + other.startTime.minute) {
        return -1;
      } else {
        return -1;
      }
    }
    return 1;
  }

  @override
  List<Object?> get props => [name, startTime, endTime, recs, userRec, userQueuePosition];
}

/// Used in settings menu.
/// Either [WeeklyLessonSettingEntity] weeklyLessons or [DatedLessonSettingEntity] datedLessons must be provided
@immutable
final class LessonSettingEntity {
  final String name;
  final List<WeeklyLessonSettingEntity>? weeklyLessons;
  final List<DatedLessonSettingEntity>? datedLessons;
  final bool useWeekly;
  LessonSettingEntity(this.name, {this.weeklyLessons, this.datedLessons, this.useWeekly = true}) {
    assert(weeklyLessons != null || datedLessons != null, "Either weeklyLessons or datedLessons must be provided");
  }

  LessonSettingEntity copyWith({String? name, List<WeeklyLessonSettingEntity>? weeklyLessons, List<DatedLessonSettingEntity>? datedLessons, bool? useWeekly}) {
    return LessonSettingEntity(name ?? this.name,
        weeklyLessons: weeklyLessons ?? this.weeklyLessons, datedLessons: datedLessons ?? this.datedLessons, useWeekly: useWeekly ?? this.useWeekly);
  }
}

@immutable
abstract final class LessonTime {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  const LessonTime(this.startTime, this.endTime);

  LessonTime copyWith({TimeOfDay? startTime, TimeOfDay? endTime});
}

@immutable
abstract class TimeChooser extends StatefulWidget {
  final int innerCount;
  final void Function(TimeOfDay, TimeOfDay) onTimeChanged;
  final void Function(double) onDeleteButtonPressed;
  const TimeChooser({required this.innerCount, required this.onTimeChanged, required this.onDeleteButtonPressed, super.key});
}

final class WeeklyLessonSettingEntity extends LessonTime {
  final List<int> weekdays;
  const WeeklyLessonSettingEntity(super.startTime, super.endTime, this.weekdays);
  @override
  WeeklyLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<int>? weekdays}) {
    return WeeklyLessonSettingEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      weekdays ?? this.weekdays,
    );
  }
}

final class DatedLessonSettingEntity extends LessonTime {
  final List<DateTime> date;
  const DatedLessonSettingEntity(super.startTime, super.endTime, this.date);
  @override
  DatedLessonSettingEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<DateTime>? date}) {
    return DatedLessonSettingEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      date ?? this.date,
    );
  }
}
