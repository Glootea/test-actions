import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';
part 'subject.freezed.dart';

@freezed
@immutable
class Subject with _$Subject {
  const factory Subject({
    required int localId,
    required String name,
    required String onlineTableID,
    required bool autoDelete,
    required bool useWorkCount,
  }) = _Subject;
  const Subject._();

  factory Subject.fromRow(List<String> row) {
    row = row.fromOnline;
    return Subject(
      localId: int.parse(row[0]),
      name: row[1],
      onlineTableID: row[2],
      autoDelete: row[3] == 'true',
      useWorkCount: row[4] == 'true',
    );
  }
  List<String> get toRow {
    final row = [
      localId.toString(),
      name,
      onlineTableID,
      if (autoDelete) 'true' else 'false',
      if (useWorkCount) 'true' else 'false',
    ];
    return row.toOnline;
  }
}

@freezed
class SubjectOnlineInfo with _$SubjectOnlineInfo {
  const factory SubjectOnlineInfo({required DateTime lastDelete}) = _SubjectInfo;

  factory SubjectOnlineInfo.fromMap(Map<String, dynamic> json) {
    return SubjectOnlineInfo(
      lastDelete: DateTime.parse(json['lastDelete'] as String), //TODO: now: 17.11.2022 -> accepted: 18-11-2022
    );
  }
}
