import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';

///To be displayed
final class LessonDisplayedEntity extends Equatable implements Comparable {
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<RecEntity> recs;
  final bool useWorkCount;
  final RecEntity? userRec;
  final int? userQueuePosition;
  const LessonDisplayedEntity(this.name, this.startTime, this.endTime, this.recs, this.useWorkCount,
      [this.userRec, this.userQueuePosition]);
  final TimeOfDay timerStartDelay = const TimeOfDay(minute: 11, hour: 0);

  bool get regIsActive => (timeToStart < timerStartDelay && const TimeOfDay(hour: 0, minute: 0) < timetillEnd);
  bool get showTimer => timeToStart < const TimeOfDay(hour: 0, minute: 30) && timerStartDelay < timeToStart;
  TimeOfDay get timeToStart => startTime - TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay get timetillEnd => endTime - TimeOfDay.fromDateTime(DateTime.now());
  LessonDisplayedEntity copyWith(
      {String? name,
      TimeOfDay? startTime,
      TimeOfDay? endTime,
      List<RecEntity>? recs,
      bool? useWorkCount,
      RecEntity? userRec,
      int? userQueuePosition}) {
    return LessonDisplayedEntity(
        name ?? this.name,
        startTime ?? this.startTime,
        endTime ?? this.endTime,
        recs ?? this.recs,
        useWorkCount ?? this.useWorkCount,
        userRec ?? this.userRec,
        userQueuePosition ?? this.userQueuePosition);
  }

  LessonDisplayedEntity copyWithoutUserRec() {
    return LessonDisplayedEntity(name, startTime, endTime, recs, useWorkCount);
  }

  @override
  int compareTo(other) {
    if (other is LessonDisplayedEntity) {
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

class SubjectInfo {
  final DateTime lastDelete;

  SubjectInfo({required this.lastDelete});
  factory SubjectInfo.fromMap(Map<String, dynamic> json) {
    return SubjectInfo(
      lastDelete: DateTime.parse(json['lastDelete'] as String), //TODO: now: 17.11.2022 -> accepted: 18-11-2022
    );
  }
}

/// Used in settings menu.
@Deprecated("Switch to freezed version")
final class LessonEntity {
  final String name;
  final List<LessonTime> lessonTimes;
  final bool autoDelete;
  final bool useWorkCount;
  LessonEntity(this.name, this.lessonTimes, this.autoDelete, this.useWorkCount);

  LessonEntity copyWith({
    String? name,
    List<LessonTime>? lessonTimes,
    bool? autoDelete,
    bool? useWorkCount,
  }) {
    return LessonEntity(
      name ?? this.name,
      lessonTimes ?? this.lessonTimes,
      autoDelete ?? this.autoDelete,
      useWorkCount ?? this.useWorkCount,
    );
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
  const TimeChooser(
      {required this.innerCount, required this.onTimeChanged, required this.onDeleteButtonPressed, super.key});
}

final class WeeklyLessonEntity extends LessonTime {
  final List<int> weekdays;
  const WeeklyLessonEntity(super.startTime, super.endTime, this.weekdays);
  @override
  WeeklyLessonEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<int>? weekdays}) {
    return WeeklyLessonEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      weekdays ?? this.weekdays,
    );
  }
}

final class DatedLessonEntity extends LessonTime {
  final List<DateTime> date;
  const DatedLessonEntity(super.startTime, super.endTime, this.date);
  @override
  DatedLessonEntity copyWith({TimeOfDay? startTime, TimeOfDay? endTime, List<DateTime>? date}) {
    return DatedLessonEntity(
      startTime ?? super.startTime,
      endTime ?? super.endTime,
      date ?? this.date,
    );
  }
}
