import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
final class RecEntity extends Equatable {
  final String userName;
  final String lessonName;
  final DateTime time;
  final bool isUploaded;
  @override
  List<Object> get props => [userName, lessonName, time, isUploaded];

  const RecEntity(this.userName, this.time, this.lessonName, [this.isUploaded = false]);
}
