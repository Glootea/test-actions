// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:queue/entities/src/new_lesson.dart';
// import 'package:queue/entities/src/new_queue_record.dart';
// import 'package:queue/extension.dart';
// import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/queue_static_background_rive.dart';
// import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/simple_clock.dart';
// import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/rounded_square_button.dart';

// part 'state_layout/no_queue.dart';
// part 'state_layout/waiting_queue_start.dart';
// part 'state_layout/queue_started.dart';
// part 'state_layout/user_in_queue.dart';

// class LessonCard extends StatefulWidget {
//   final Lesson lesson;
//   final List<NewQueueRecord> recList;
//   const LessonCard(this.lesson, this.recList, {super.key});

//   @override
//   State<LessonCard> createState() => _LessonCardState();
// }

// class _LessonCardState extends State<LessonCard> {
//   @override
//   Widget build(BuildContext context) {
//     final startTime = widget.lesson.startTime;
//     final endTime = widget.lesson.endTime;
//     final queueStart = startTime.subtract(const Duration(minutes: 5));
//     final now = DateTime.now().add(const Duration(seconds: 2)); // TODO: find a way to remove +2
//     final isQueueNow = queueStart.isBefore(now) && now.isBefore(endTime);
//     final isQueueStartSoon = (queueStart.difference(now) < const Duration(minutes: 60)) && now.isBefore(queueStart);
//     final userQueueRecord = widget.recList.where((rec) => rec.studentRowNumber == 1).firstOrNull; // userCubit.rowNumber
//     final userInQueue = userQueueRecord != null;
//     print((isQueueNow, isQueueStartSoon, userInQueue));
//     return Card(
//         clipBehavior: Clip.antiAlias,
//         margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 100, vertical: 8),
//         color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: switch ((isQueueNow, isQueueStartSoon, userInQueue)) {
//           (true, _, false) => _QueueStarted(lesson: widget.lesson),
//           (_, true, false) => _WaitingQueueStart(lesson: widget.lesson, onEnd: () => setState(() {})),
//           (false, false, false) => _NoQueue(widget.lesson),
//           (_, _, true) => _UserInQueue(lesson: widget.lesson, userRecord: userQueueRecord!),
//         });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/screens/main/main_screen_cubit.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/rounded_square_button.dart';

enum _ButtonState { add, remove, qrCode }

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  const LessonCard(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodayScreenCubit>();
    return FutureBuilder(
        future: bloc.getUserQueueData(), // getting user record from local database
        builder: (context, snapshot) {
          final userQueueRecordStatus = snapshot.data?.$1.status;
          final buttonState = switch ((lesson.state, userQueueRecordStatus)) {
            (_, QueueRecordStatus.shouldBeUploaded) => _ButtonState.qrCode,
            (LessonState.active, null) => _ButtonState.add,
            (LessonState.active, QueueRecordStatus.uploaded) ||
            (LessonState.active, QueueRecordStatus.shouldBeUploaded) =>
              _ButtonState.remove,
            (_, _) => null
          };
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 64,
                          child: Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Text(
                              lesson.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      if (buttonState != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: LessonCardButton(
                            icon: switch (buttonState) {
                              _ButtonState.qrCode => Icons.qr_code_outlined,
                              _ButtonState.add => Icons.add,
                              _ButtonState.remove => Icons.remove_outlined,
                            },
                            onTap: () => switch (buttonState) {
                              _ButtonState.qrCode => bloc.showQrCode(queueRecord: snapshot.data?.$1),
                              _ButtonState.add => bloc.addQueueRecord(subjectLocalID: lesson.subjectLocalID),
                              _ButtonState.remove => bloc.deleteQueueRecord(queueRecord: snapshot.data!.$1),
                            },
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: Text(
                          '${lesson.startTime.toDisplayTime} - ${lesson.endTime.toDisplayTime}', //TODO: add classroom to lesson class
                          // '16:20 - 17:50 в Г-321',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data?.$2 ?? '',
                        // 'Вы не находитесь в очереди',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Icon(
                        Icons.expand_more,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
