import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';

part 'lesson_time.freezed.dart';

abstract class LessonTime {
  final int id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  const LessonTime(this.id, this.startTime, this.endTime);

  List<String> get toRow;
}

@freezed
class WeeklyLessonEntity extends LessonTime with _$WeeklyLessonEntity {
  const factory WeeklyLessonEntity({
    required int id,
    required List<int> weekdays,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) = _WeeklyLessonEntity;

  const WeeklyLessonEntity._() : super(0, const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0));
  factory WeeklyLessonEntity.fromRow(List<String> row) {
    row = row.fromOnline;
    return WeeklyLessonEntity(
      id: int.parse(row[0]),
      weekdays: row[2].toWeekDays,
      startTime: row[2].toTimeOfDay,
      endTime: row[3].toTimeOfDay,
    );
  }

  @override
  List<String> get toRow {
    final row = [
      id.toString(),
      '-',
      weekdays.toOnlineString,
      startTime.toDisplayTime,
      endTime.toDisplayTime,
    ];
    return row.toOnline;
  }
}

@freezed
class DatedLessonEntity extends LessonTime with _$DatedLessonEntity {
  const factory DatedLessonEntity({
    required int id,
    required List<DateTime> dates,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) = _NewDatedLessonEntity;

  const DatedLessonEntity._() : super(0, const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0));
  factory DatedLessonEntity.fromRow(List<String> row) {
    row = row.fromOnline;
    return DatedLessonEntity(
      id: int.parse(row[0]),
      dates: row[2].toDatesList,
      startTime: row[2].toTimeOfDay,
      endTime: row[3].toTimeOfDay,
    );
  }

  @override
  List<String> get toRow {
    final row = [
      id.toString(),
      dates.toDatesString.toOnline,
      '-',
      startTime.toDisplayTime.toOnline,
      endTime.toDisplayTime.toOnline,
    ];
    return row.toOnline;
  }
}
