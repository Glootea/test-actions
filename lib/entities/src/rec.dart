import 'package:equatable/equatable.dart';

/// Rec - Record (Запись)
final class RecEntity extends Equatable implements Comparable {
  final String userName;
  final String lessonName;
  final DateTime time;
  final int? workCount;
  final bool isUploaded;
  @override
  List<Object> get props => [userName, lessonName, time, isUploaded, workCount ?? 0];

  const RecEntity(this.userName, this.time, this.lessonName, {this.isUploaded = false, this.workCount});

  @override
  int compareTo(other) {
    // TODO: rewrite to implement weighted sort with work count
    return time.compareTo(other.time);
  }
}
