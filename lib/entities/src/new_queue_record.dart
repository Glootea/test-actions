import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';

part 'new_queue_record.freezed.dart';

enum NewQueueRecordStatus {
  uploaded('Uploaded'),
  shouldBeUploaded('Should be uploaded'),
  shouldBeDeleted('Should be deleted'),
  ;

  final String name;
  @override
  String toString() => name;

  const NewQueueRecordStatus(this.name);
}

@freezed
class NewQueueRecord with _$NewQueueRecord {
  const NewQueueRecord._();
  const factory NewQueueRecord({
    required int localSubjectID,
    required String onlineTableID,
    required int studentRowNumber,
    required DateTime time,
    required int? workCount,
    required NewQueueRecordStatus status,
  }) = _NewQueueRecord;

  List<String> get toOnlineRow => [time.toRecTime, workCount.toString()].toOnline;
}
