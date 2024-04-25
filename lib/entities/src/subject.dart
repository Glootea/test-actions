import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/extension.dart';
part 'subject.freezed.dart';

@freezed
@immutable
class Subject with _$Subject {
  const Subject._();
  const factory Subject({
    required int localId,
    required String name,
    required String onlineTableID,
    required bool autoDelete,
    required bool useWorkCount,
  }) = _Subject;

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
      autoDelete ? 'true' : 'false',
      useWorkCount ? 'true' : 'false',
    ];
    return row.toOnline;
  }
}
