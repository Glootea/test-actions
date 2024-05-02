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

@freezed
class Lesson with _$Lesson {
  const Lesson._();
  const factory Lesson({
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required int subjectLocalID,
    required String subjectOnlineTableID,
  }) = _NewLesson;
}
