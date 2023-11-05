import 'package:flutter/material.dart';
import 'package:queue/entities/rec.dart';

///To be displayed
final class LessonEntity {
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<RecEntity> recs;
  final RecEntity? userRec;
  final int? userQueuePosition;
  LessonEntity(this.name, this.startTime, this.endTime, this.recs,
      [this.userRec, this.userQueuePosition]);
}
