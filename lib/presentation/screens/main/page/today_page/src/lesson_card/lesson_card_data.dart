import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';
part 'lesson_card_data.freezed.dart';

@freezed
class LessonCardData with _$LessonCardData {
  const LessonCardData._();
  const factory LessonCardData({
    required Lesson lesson,
    required QueueRecordStatus? userRecordStatus,
  }) = _LessonCardData;

  String get userStateData => switch (userRecordStatus) {
        null => 'Вы не находитесь в очереди',
        QueueRecordStatus.uploaded => 'Вы в очереди',
        QueueRecordStatus.shouldBeUploaded || QueueRecordStatus.shouldBeDeleted => 'Ошибка сети',
      };
}
