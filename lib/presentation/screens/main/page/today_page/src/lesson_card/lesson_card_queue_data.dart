import 'package:freezed_annotation/freezed_annotation.dart';
part 'lesson_card_queue_data.freezed.dart';

@freezed
class LessonCardQueueData with _$LessonCardQueueData {
  const factory LessonCardQueueData({
    required int queueLength,
    required int queuePosition,

    /// Описание очереди: "Вы 3 в очереди после Name".
    required String message,
  }) = _LessonCardQueueData;
}
