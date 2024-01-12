import 'package:flutter/material.dart';

extension TimeArithmetic on TimeOfDay {
  TimeOfDay operator -(TimeOfDay other) {
    int totalMinutes = (hour - other.hour) * 60 + (minute - other.minute);
    if (totalMinutes <= 0) return const TimeOfDay(hour: 0, minute: 0);
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  bool operator <(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    if (minute < other.minute) return true;
    return false;
  }

  bool operator <=(TimeOfDay other) {
    if (hour <= other.hour) return true;
    if (hour > other.hour) return false;
    if (minute <= other.minute) return true;
    return false;
  }

  String get toShortString {
    return '$hour:${minute < 10 ? '0$minute' : minute}';
  }
}

extension TimeFromString on String {
  TimeOfDay get toTimeOfDay {
    final List<int> a = split('(').last.split(')').first.split(':').map((e) => int.parse(e)).toList();
    return TimeOfDay(hour: a[0], minute: a[1]);
  }

  ///Used to store time in online spreadsheet to prevent from being proportion of day
  String get toOnlineTime {
    return "'$this";
  }
}

extension DateToString on DateTime {
  String get toDateString {
    return '$day.$month.$year';
  }
}

extension DateStringToDate on String {
  DateTime get toDate {
    final numbers = split('.').map((e) => int.parse(e)).toList();
    return DateTime(numbers[0], numbers[1], numbers[2]);
  }
}

class MultipleFilesOnDiskException implements Exception {
  final String message;
  MultipleFilesOnDiskException(this.message);
}

class NoFileFoundOnDiskException implements Exception {
  final String message;
  NoFileFoundOnDiskException(this.message);
}
