import 'package:flutter/material.dart';

@immutable
final class StudentEntity {
  final String name;
  final bool isAdmin;
  StudentEntity copyWith({String? name, bool? isAdmin}) {
    return StudentEntity(name ?? this.name, isAdmin: isAdmin ?? this.isAdmin);
  }

  const StudentEntity(this.name, {this.isAdmin = false});
}
