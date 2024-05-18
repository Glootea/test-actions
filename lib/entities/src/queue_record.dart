import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';

part 'queue_record.freezed.dart';

enum QueueRecordStatus {
  uploaded('Uploaded'),
  shouldBeUploaded('Should be uploaded'),
  shouldBeDeleted('Should be deleted'),
  ;

  final String name;
  @override
  String toString() => name;

  const QueueRecordStatus(this.name);
}

@freezed
class QueueRecord with _$QueueRecord {
  const QueueRecord._();
  const factory QueueRecord({
    required int localSubjectID,
    required String onlineTableID,
    required int studentRowNumber,
    required DateTime time,
    int? workCount,
    required QueueRecordStatus status,
  }) = _QueueRecord;
  static QueueRecord parseFromString(String qrData) {
    //TODO: implement NewQueueRecord parseFromString
    return QueueRecord(
        status: QueueRecordStatus.uploaded,
        localSubjectID: 0,
        onlineTableID: qrData,
        studentRowNumber: 0,
        time: DateTime.now(),
        workCount: 0);
  }

  List<String> get toOnlineRow => [time.toRecTime, workCount.toString()].toOnline;
}
