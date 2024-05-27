import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/entities/src/queue_record.dart';
part 'queue_data.freezed.dart';

@freezed
class QueueData with _$QueueData {
  const QueueData._();
  const factory QueueData({
    required List<QueueRecord> queueRecordList,
    required int queueLength,
    required int? userPosition,
    required QueueRecord? userRecord,
    required bool live, // fetched online or locally
  }) = _QueueData;

  String? get previousStudentName {
    if (userPosition != null) {
      return queueRecordList[userPosition! - 1].studentName;
    }
    return null;
  }
}
