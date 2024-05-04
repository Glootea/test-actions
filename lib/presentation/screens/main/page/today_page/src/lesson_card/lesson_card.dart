import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/queue_static_background_rive.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/simple_clock.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/rounded_square_button.dart';

part 'state_layout/no_queue.dart';
part 'state_layout/waiting_queue_start.dart';
part 'state_layout/queue_started.dart';
part 'state_layout/user_in_queue.dart';

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  final List<NewQueueRecord> recList;
  const LessonCard(this.lesson, this.recList, {super.key});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  @override
  Widget build(BuildContext context) {
    final startTime = widget.lesson.startTime;
    final endTime = widget.lesson.endTime;
    final queueStart = startTime.subtract(const Duration(minutes: 5));
    final now = DateTime.now().add(const Duration(seconds: 2)); // TODO: find a way to remove +2
    final isQueueNow = queueStart.isBefore(now) && now.isBefore(endTime);
    final isQueueStartSoon = (queueStart.difference(now) < const Duration(minutes: 60)) && now.isBefore(queueStart);
    final userQueueRecord = widget.recList.where((rec) => rec.studentRowNumber == 1).firstOrNull; // userCubit.rowNumber
    final userInQueue = userQueueRecord != null;
    print((isQueueNow, isQueueStartSoon, userInQueue));
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 100, vertical: 8),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: switch ((isQueueNow, isQueueStartSoon, userInQueue)) {
          (true, _, false) => _QueueStarted(lesson: widget.lesson),
          (_, true, false) => _WaitingQueueStart(lesson: widget.lesson, onEnd: () => setState(() {})),
          (false, false, false) => _NoQueue(widget.lesson),
          (_, _, true) => _UserInQueue(lesson: widget.lesson, userRecord: userQueueRecord!),
        });
  }
}
