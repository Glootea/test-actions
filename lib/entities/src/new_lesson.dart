import 'package:freezed_annotation/freezed_annotation.dart';
part 'new_lesson.freezed.dart';

@freezed
class NewLesson with _$NewLesson {
  const factory NewLesson(
      {required String name,
      required int localID,
      required String onlineTableID,
      required DateTime startTime,
      required DateTime endTime}) = _NewLesson;
}
