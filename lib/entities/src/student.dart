import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

@freezed
class StudentEntity with _$StudentEntity {
  const factory StudentEntity({
    required String name,
    required bool isAdmin,
    required int onlineTableRowNumber,
  }) = _StudentEntity;
}
