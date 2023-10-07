import 'package:flutter/material.dart';
import 'package:queue/models/lesson.dart';
import 'package:queue/presentation/widgets/timer_start_reg.dart';

class LessonWidget extends StatefulWidget {
  final Lesson lesson;
  const LessonWidget(this.lesson, {super.key});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  DateTime get now => DateTime.now();
  bool get regIsActive => (timeToStart < const TimeOfDay(minute: 10, hour: 0) &&
      const TimeOfDay(hour: 0, minute: 0) < timetillEnd);
  TimeOfDay get timeToStart =>
      widget.lesson.pair.startTime - TimeOfDay.fromDateTime(now);
  TimeOfDay get timetillEnd =>
      widget.lesson.pair.endTime - TimeOfDay.fromDateTime(now);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Column(
        children: [
          Text(
            widget.lesson.displayName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(regIsActive ? "Запись открыта" : "Запись закрыта"),
          if (regIsActive) TimerStartReg(widget.lesson.pair.startTime)
        ],
      ),
    );
  }
}

extension TimeArithmetic on TimeOfDay {
  TimeOfDay operator -(TimeOfDay other) {
    if ((minute - other.minute < 0) || (hour - other.hour < 0)) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    if (minute - other.minute < 0) {
      return TimeOfDay(
          hour: hour - other.hour - 1, minute: 60 + minute - other.minute);
    }
    return TimeOfDay(hour: hour - other.hour, minute: minute - other.minute);
  }

  bool operator <(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    if (minute < other.minute) return true;
    return false;
  }
}
