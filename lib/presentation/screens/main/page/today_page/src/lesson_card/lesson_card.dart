import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/screens/main/today_screen_cubit.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/lesson_card_data.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/lesson_card_queue_data.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/queue_static_background_rive.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/simple_clock.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/rounded_square_button.dart';

part 'state_layout/no_queue.dart';
part 'state_layout/waiting_queue_start.dart';
part 'state_layout/queue_started.dart';
part 'state_layout/user_in_queue.dart';

@Deprecated("Use NewLessonCard. Reasons: - Get string from bloc. - Add progress bar")
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

class NewLessonCard extends StatefulWidget {
  final LessonCardData data;
  const NewLessonCard(this.data, {super.key});

  @override
  State<NewLessonCard> createState() => _NewLessonCardState();
}

class _NewLessonCardState extends State<NewLessonCard> {
  Stream? queueDataStream;
  @override
  void initState() {
    final cubit = context.read<TodayScreenCubit>();
    queueDataStream = widget.data.lesson.status == LessonStatus.active || widget.data.userRecordStatus != null
        ? cubit.getQueueDataStream(widget.data.lesson.id)
        : null;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewLessonCard oldWidget) {
    if (oldWidget.data.lesson.status != widget.data.lesson.status) {
      // отписаться от старого и подписаться на новый stream получения очереди
      final cubit = context.read<TodayScreenCubit>();
      cubit.disposeStream(widget.data.lesson.id);
      queueDataStream = widget.data.lesson.status == LessonStatus.active || widget.data.userRecordStatus != null
          ? cubit.getQueueDataStream(widget.data.lesson.id)
          : null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 100, vertical: 8),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 8),
          child: StreamBuilder(
            stream: queueDataStream,
            builder: (context, queueData) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.lesson.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                              "${widget.data.lesson.startTime.toDisplayTime} - ${widget.data.lesson.endTime.toDisplayTime} в ${widget.data.lesson.room}"),
                        ],
                      ),
                    ),
                  ),
                  if (widget.data.lesson.status == LessonStatus.active || widget.data.userRecordStatus != null)
                    RoundedSquareButton(
                        size: 64,
                        onPressed: () {},
                        child: Icon(
                          switch (widget.data.userRecordStatus) {
                            QueueRecordStatus.shouldBeUploaded => Icons.qr_code_outlined,
                            QueueRecordStatus.uploaded => Icons.remove_outlined,
                            null => Icons.add_outlined,
                            QueueRecordStatus.shouldBeDeleted => null,
                          },
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ))
                ],
              ),
              (queueData.data != null)
                  ? LinearProgressIndicator(value: queueData.data!.queuePosition / queueData.data!.queueLength)
                  : const Divider(),
              Text(widget.data.userRecordStatus != null ? queueData.data!.message : widget.data.userStateData),
            ]),
          ),
        ));
  }
}
