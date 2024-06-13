import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/src/lesson_time.dart';
part 'subject_data.freezed.dart';

@freezed
class SubjectData with _$SubjectData {
  const factory SubjectData({
    required String name,
    required bool useWorkCount,
    required bool useAutoDelete,
    required double? queueKoef,
    required List<LessonTime> lessonTimes,
  }) = _SubjectData;
}
