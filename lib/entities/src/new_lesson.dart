import 'package:freezed_annotation/freezed_annotation.dart';
part 'new_lesson.freezed.dart';

// @freezed
// class Lesson with _$Lesson {
//   const factory Lesson(
//       {required String name,
//       required int localID,
//       required String onlineTableID,
//       required DateTime startTime,
//       required DateTime endTime}) = _NewLesson;
// }
enum LessonStatus { willStart, soon, active, ended }

@freezed
class Lesson with _$Lesson {
  const Lesson._();
  const factory Lesson({
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required int id, // subjectLocalID
    required String subjectOnlineTableID,
    required String room,
  }) = _NewLesson;

  final Duration _durationQueueStartsBeforeLesson = const Duration(minutes: 5);
  DateTime get queueStartTime => startTime.subtract(_durationQueueStartsBeforeLesson);

  LessonStatus get status => switch ((queueStartTime, endTime)) {
        (DateTime start, DateTime end) when (start.isBefore(DateTime.now()) && end.isAfter(DateTime.now())) =>
          LessonStatus.active,
        (_, DateTime end) when (end.isBefore(DateTime.now())) => LessonStatus.ended,
        (DateTime start, _) when (start.difference(DateTime.now()) < const Duration(minutes: 5)) => LessonStatus.soon,
        (DateTime start, _) when (start.isAfter(DateTime.now())) => LessonStatus.willStart,
        // TODO: Handle this case.
        (_, _) => throw UnimplementedError(),
      };
}
