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

  DateTime get toRecDateTime {
    List<int> list = split('-').map((e) => int.parse(e)).toList();
    return DateTime(list[0], list[1], list[2], list[3], list[4], list[5], list[6]);
  }

  ///Used to store time in online spreadsheet to prevent from being proportion of day
  String get toOnlineTime {
    return "'$this";
  }
}

extension DateToString on DateTime {
  String get toOnlineDateString {
    return "'$day.$month.$year";
  }

  String get toRecTime {
    return '$year-$month-$day-$hour-$minute-$second-$millisecond';
  }
}

extension DateStringToDate on String {
  DateTime get toDate {
    final numbers = split('.').map((e) => int.parse(e)).toList();
    return DateTime(numbers[2], numbers[1], numbers[0]);
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
