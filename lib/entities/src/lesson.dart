import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'lesson.freezed.dart';

@freezed
class SubjectInfo with _$SubjectInfo {
  const factory SubjectInfo({required DateTime lastDelete}) = _SubjectInfo;

  factory SubjectInfo.fromMap(Map<String, dynamic> json) {
    return SubjectInfo(
      lastDelete: DateTime.parse(json['lastDelete'] as String), //TODO: now: 17.11.2022 -> accepted: 18-11-2022
    );
  }
}

abstract class TimeChooser extends StatefulWidget {
  final int innerCount;
  final void Function(TimeOfDay, TimeOfDay) onTimeChanged;
  final void Function(double) onDeleteButtonPressed;
  const TimeChooser(
      {required this.innerCount, required this.onTimeChanged, required this.onDeleteButtonPressed, super.key});
}
