import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/extension.dart';

part 'queue_record.freezed.dart';

enum UploadStatus {
  uploaded('Uploaded'),
  shouldBeUploaded('Should be uploaded'),
  shouldBeDeleted('Should be deleted'),
  ;

  const UploadStatus(this.name);

  final String name;
  @override
  String toString() => name;
}

@freezed
class QueueRecord with _$QueueRecord {
  const factory QueueRecord({
    required Lesson lesson,
    required String studentName,
    required int studentID,
    required DateTime time,
    required UploadStatus status,
    int? workCount,
  }) = _QueueRecord;

  /// Used for optimistic UI to show updates before it is uploaded to the server
  factory QueueRecord.shouldBeUploaded(Lesson lesson, int studentID) => QueueRecord(
        lesson: lesson,
        studentName: '',
        studentID: studentID,
        time: DateTime.now(),
        status: UploadStatus.shouldBeUploaded,
      );
  const QueueRecord._();

  factory QueueRecord.parseFromString(String qrData) {
    //TODO: implement NewQueueRecord parseFromString
    return QueueRecord(
      status: UploadStatus.uploaded,
      lesson: Lesson(
        name: 'Lesson sample name',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        subjectLocalID: 0,
        subjectOnlineTableID: 'dfkjnb',
      ),
      studentID: 0,
      studentName: 'Student sample name',
      time: DateTime.now(),
      workCount: 0,
    );
  }

  List<String> get toOnlineRow => [time.toRecTime, workCount.toString()].toOnline;
}
