import 'package:freezed_annotation/freezed_annotation.dart';
part 'lesson.freezed.dart';

enum LessonStatus { inFuture, soon, active, inPast }

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

  factory Lesson.empty() => Lesson(
        name: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        subjectLocalID: 0,
        subjectOnlineTableID: '',
      );

  LessonStatus get status {
    final now = DateTime.now();
    if (startTime.subtract(const Duration(minutes: 5)).isBefore(now) && endTime.isAfter(now)) {
      return LessonStatus.active;
    }
    if (startTime.isAfter(now) && startTime.difference(now) < const Duration(hours: 1)) {
      return LessonStatus.soon;
    }
    if (startTime.isAfter(now)) {
      return LessonStatus.inFuture;
    }
    if (endTime.isBefore(now)) {
      return LessonStatus.inPast;
    }
    return LessonStatus.soon;
  }

  static Duration queueStartDifference = const Duration(minutes: 5);
  DateTime get queueStartTime => startTime.subtract(queueStartDifference);
}
