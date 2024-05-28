import 'package:flutter/material.dart';

extension TimeFromString on String {
  TimeOfDay get toTimeOfDay {
    final List<int> a = split('(').last.split(')').first.split(':').map((e) => int.parse(e)).toList();
    return TimeOfDay(hour: a[0], minute: a[1]);
  }

  DateTime get toRecDateTime {
    List<int> list = split('-').map((e) => int.parse(e)).toList();
    return DateTime(list[0], list[1], list[2], list[3], list[4], list[5], list[6]);
  }

  DateTime get toDate {
    final numbers = split('.').map((e) => int.parse(e)).toList();
    return DateTime(numbers[2], numbers[1], numbers[0]);
  }

  List<DateTime> get toDatesList => split(',').map((e) => e.toDate).toList();

  List<int> get toIntList => split(',').map((e) => int.parse(e)).toList();
}

extension DateToString on DateTime {
  String get toDateString {
    return "$day.$month.$year";
  }

  String get toRecTime {
    return '$year-$month-$day-$hour-$minute-$second-$millisecond';
  }

  String get toFullDisplayTime =>
      '$month/$day $hour:${minute < 10 ? '0$minute' : minute}:${second < 10 ? '0$second' : second}:${millisecond < 10 ? '0$millisecond' : millisecond}';

  String get toDisplayTime => '$hour:${minute < 10 ? '0$minute' : minute}';
}

extension TimeOfDayFormatter on TimeOfDay {
  String get toDisplayTime => '$hour:${minute < 10 ? '0$minute' : minute}';
}

extension WeekDays on List<int> {
  String get toOnlineString => join(',');
}

extension Dates on List<DateTime> {
  String get toDatesString => map((e) => e.toDateString).join(',');
}

class MultipleFilesOnDiskException implements Exception {
  final String message;
  MultipleFilesOnDiskException(this.message);
}

class NoFileFoundOnDiskException implements Exception {
  final String message;
  NoFileFoundOnDiskException(this.message);
}

extension HandleBlank on List<String> {
  /// Useful when selecting several columns at a time for mathing rows
  List<String?> get getHandledBlanks => map((cell) => cell.isEmpty ? null : cell).toList();
  List<String> get removeBlanks => where((cell) => cell.isNotEmpty).toList();
  List<String> get toOnline => map((e) => e.toOnline).toList();
  List<String> get fromOnline => map((e) => e.fromOnline).toList();
}

extension Online on String {
  String get toOnline => "'$this";
  String get fromOnline => substring(1);
}
