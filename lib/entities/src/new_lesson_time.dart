import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';

part 'new_lesson_time.freezed.dart';

abstract class NewLessonTime {
  final int id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  const NewLessonTime(this.id, this.startTime, this.endTime);

  List<String> get toRow;
}

@freezed
class NewWeeklyLessonEntity extends NewLessonTime with _$NewWeeklyLessonEntity {
  const factory NewWeeklyLessonEntity({
    required int id,
    required List<int> weekdays,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) = _NewWeeklyLessonEntity;

  const NewWeeklyLessonEntity._() : super(0, const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0));
  factory NewWeeklyLessonEntity.fromRow(List<String> row) {
    row = row.fromOnline;
    return NewWeeklyLessonEntity(
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
      startTime.toOnlineString,
      endTime.toOnlineString,
    ];
    return row.toOnline;
  }
}

@freezed
class NewDatedLessonEntity extends NewLessonTime with _$NewDatedLessonEntity {
  const factory NewDatedLessonEntity({
    required int id,
    required List<DateTime> dates,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) = _NewDatedLessonEntity;

  const NewDatedLessonEntity._() : super(0, const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0));
  factory NewDatedLessonEntity.fromRow(List<String> row) {
    row = row.fromOnline;
    return NewDatedLessonEntity(
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
      dates.toOnlineString,
      '-',
      startTime.toOnlineString,
      endTime.toOnlineString,
    ];
    return row.toOnline;
  }
}
