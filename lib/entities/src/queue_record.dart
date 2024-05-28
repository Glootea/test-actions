import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/extension.dart';

part 'queue_record.freezed.dart';

enum UploadStatus {
  uploaded('Uploaded'),
  shouldBeUploaded('Should be uploaded'),
  shouldBeDeleted('Should be deleted'),
  ;

  final String name;
  @override
  String toString() => name;

  const UploadStatus(this.name);
}

@freezed
class QueueRecord with _$QueueRecord {
  const QueueRecord._();
  const factory QueueRecord({
    required Lesson lesson,
    required String studentName,
    required int studentID,
    required DateTime time,
    required UploadStatus status,
    int? workCount,
  }) = _QueueRecord;

  static QueueRecord parseFromString(String qrData) {
    //TODO: implement NewQueueRecord parseFromString
    return QueueRecord(
        status: UploadStatus.uploaded,
        lesson: Lesson(
            name: "Lesson sample name",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            subjectLocalID: 0,
            subjectOnlineTableID: 'dfkjnb'),
        studentID: 0,
        studentName: "Student sample name",
        time: DateTime.now(),
        workCount: 0);
  }

  List<String> get toOnlineRow => [time.toRecTime, workCount.toString()].toOnline;
}
