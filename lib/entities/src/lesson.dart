import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'lesson.freezed.dart';

enum LessonState { inFuture, soon, active, inPast }

@freezed
class Lesson with _$Lesson {
  const Lesson._();
  const factory Lesson({
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required int subjectLocalID,
    required String subjectOnlineTableID,
  }) = _Lesson;

  LessonState get state {
    final now = DateTime.now();
    log("now: $now, start: $startTime, end: $endTime");
    if (startTime.subtract(const Duration(minutes: 5)).isBefore(now) && endTime.isAfter(now)) {
      return LessonState.active;
    }
    if (startTime.isAfter(now) && startTime.difference(now) < const Duration(hours: 1)) {
      return LessonState.soon;
    }
    if (startTime.isAfter(now)) {
      return LessonState.inFuture;
    }
    if (endTime.isBefore(now)) {
      return LessonState.inPast;
    }
    return LessonState.soon;
  }
}
