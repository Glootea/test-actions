import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/queue_data/queue_data.dart';
part 'lesson_card_data.freezed.dart';

@freezed
class LessonCardData with _$LessonCardData {
  const factory LessonCardData({
    required Lesson lesson,
    required bool attended,
    required QueueData? queueData,
  }) = _LessonCardData;
  const LessonCardData._();

  String get message => switch ((queueData?.userRecord?.status, lesson.status)) {
        // user, lesson
        (null, final LessonStatus status) when status != LessonStatus.active && status != LessonStatus.soon =>
          'Вы не находитесь в очереди',
        (UploadStatus.uploaded, _) => 'Вы ${queueData?.userPosition} в очереди после ${queueData?.previousStudentName}',
        (final UploadStatus status, _)
            when status == UploadStatus.shouldBeUploaded || status == UploadStatus.shouldBeDeleted =>
          'Ошибка сети',
        (_, LessonStatus.soon) => 'Очередь начнется в ${lesson.queueStartTime.toDisplayTime}',
        (_, LessonStatus.active) => 'Очередь началась!',
        (_, _) => throw UnimplementedError(
            "${queueData?.userRecord?.status}, ${lesson.status} is unknown status to get LessonCardData's message",)
      };
  ButtonState get buttonState => switch ((lesson.status, queueData?.userRecord?.status)) {
        (_, UploadStatus.shouldBeUploaded) => ButtonState.qrCode,
        (LessonStatus.active, null) => ButtonState.add,
        (LessonStatus.active, UploadStatus.uploaded) ||
        (LessonStatus.active, UploadStatus.shouldBeUploaded) =>
          ButtonState.remove,
        (_, _) => ButtonState.none
      };
  UploadStatus? get queueRecordStatus => queueData?.userRecord?.status;
}
