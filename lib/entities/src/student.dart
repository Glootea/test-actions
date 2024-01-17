import 'package:flutter/material.dart';

@immutable
final class StudentEntity {
  final String name;
  final bool isAdmin;
  final int onlineTableRowNumber;
  StudentEntity copyWith({String? name, int? onlineTableRowNumber, bool? isAdmin}) {
    return StudentEntity(name ?? this.name, onlineTableRowNumber ?? this.onlineTableRowNumber, isAdmin: isAdmin ?? this.isAdmin);
  }

  const StudentEntity(this.name, this.onlineTableRowNumber, {this.isAdmin = false});
}
