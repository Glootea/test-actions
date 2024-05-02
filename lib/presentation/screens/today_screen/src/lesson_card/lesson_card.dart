import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/entities/src/new_queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/new_domain/user_cubit.dart';
import 'package:queue/presentation/screens/today_screen/src/lesson_card/src/simple_clock.dart';
import 'package:queue/presentation/screens/today_screen/src/rounded_square_button.dart';
import 'package:rive/rive.dart';

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
    final UserCubit userCubit = context.read<UserCubit>();
    final startTime = widget.lesson.startTime;
    final endTime = widget.lesson.endTime;
    final queueStart = startTime.subtract(const Duration(minutes: 5));
    final now = DateTime.now().add(const Duration(seconds: 2)); // TODO: find a way to remove +2
    final isQueueNow = queueStart.isBefore(now) && now.isBefore(endTime);
    final isQueueStartSoon = now.difference(queueStart) < const Duration(minutes: 60) && now.isBefore(queueStart);
    print(widget.recList);
    final userQueueRecord = widget.recList.where((rec) => rec.studentRowNumber == 1).firstOrNull; // userCubit.rowNumber
    final userInQueue = userQueueRecord != null;
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 20, vertical: 8),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: switch ((isQueueNow, isQueueStartSoon, userInQueue)) {
          (true, _, false) => _QueueStarted(lesson: widget.lesson),
          (_, true, false) => _WaitingQueueStart(lesson: widget.lesson, onEnd: () => setState(() {})),
          (false, false, false) => _NoQueue(widget.lesson),
          (_, _, true) => _UserInQueue(lesson: widget.lesson, userRecord: userQueueRecord!),
        });
    // child: _WaitingQueueStart(lesson: lesson, onEnd: () => build(context)));
  }
}

class _NoQueue extends StatelessWidget {
  final Lesson lesson;

  const _NoQueue(this.lesson);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(children: [
          Positioned.fill(
              child: Align(
            alignment: Alignment.centerRight,
            child: SimpleClock(startTime: lesson.startTime, size: 64),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lesson.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start),
              Text("${lesson.startTime.toDisplayTime} - ${lesson.endTime.toDisplayTime}",
                  overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
            ],
          )
        ]));
  }
}

class _WaitingQueueStart extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onEnd;
  const _WaitingQueueStart({required this.lesson, required this.onEnd, super.key});

  @override
  Widget build(BuildContext context) {
    final queueStart = lesson.startTime.subtract(const Duration(minutes: 5));
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(children: [
          Positioned.fill(
              child: Align(
            alignment: Alignment.centerRight,
            child: CountDownClock(
              expireTime: queueStart,
              size: 64,
              onEnd: onEnd,
            ),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lesson.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start),
              Text(
                "${lesson.startTime.toDisplayTime} - ${lesson.endTime.toDisplayTime}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              Text(
                "Начало очереди в ${queueStart.toDisplayTime}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ],
          )
        ]));
  }
}

class _QueueStarted extends StatelessWidget {
  final Lesson lesson;
  final double height;
  const _QueueStarted({required this.lesson, this.height = 240.0});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
          top: height / 3,
          child: const QueueStaticBackgroundRive(
            userInQueue: false,
            size: 200,
          )),
      IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lesson.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start),
                  Text("${lesson.startTime.toDisplayTime} - ${lesson.endTime.toDisplayTime}",
                      overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
          RoundedSquareButton(
            onPressed: () {},
            child: const Icon(Icons.add_outlined),
          )
        ]),
      )
    ]);
  }
}

class QueueStaticBackgroundRive extends StatelessWidget {
  final double size;
  final bool userInQueue;
  const QueueStaticBackgroundRive({
    super.key,
    required this.size,
    required this.userInQueue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: OverflowBox(
        minHeight: size,
        minWidth: size,
        maxHeight: size,
        maxWidth: size,
        child: RiveAnimation.asset("assets/queue.riv",
            alignment: const Alignment(0.7, 0.5),
            stateMachines: const ['main'],
            placeHolder: Container(),
            fit: BoxFit.contain, onInit: (artboard) {
          final controller = StateMachineController.fromArtboard(
            artboard,
            'main',
            // onStateChange: (stateMachineName, stateName) => print('$stateMachineName $stateName'),
          );
          controller?.isActive = false;
          artboard.addController(controller!);
          controller.findInput<bool>('play start')?.value = true;
          controller.findInput<bool>('to background')?.value = true;
          // final color = Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.2);
          // final color = Colors.yellow;
          artboard.forEachComponent(
            (child) {
              // print(child.name);
              if (child is Shape) {
                final Shape shape = child;
                if (shape.name == 'Head' || shape.name == 'Body') {
                  shape.strokes.first.paint.colorFilter = ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6), BlendMode.src);
                  if (userInQueue && child.parent?.name == "Person 2") {
                    shape.strokes.first.paint.colorFilter =
                        ColorFilter.mode(Theme.of(context).colorScheme.error.withOpacity(0.6), BlendMode.src);
                  }
                }
              }
            },
          );
          controller.isActive = true;
        }),
      ),
    );
  }
}

class _UserInQueue extends StatefulWidget {
  final Lesson lesson;
  final NewQueueRecord userRecord;
  final double height;
  _UserInQueue({required this.lesson, required this.userRecord, this.height = 240.0});

  @override
  State<_UserInQueue> createState() => _UserInQueueState();
}

class _UserInQueueState extends State<_UserInQueue> {
  bool expandded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        expandded = !expandded;
      }),
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 300),
        child: Stack(alignment: Alignment.topCenter, children: [
          const Positioned.fill(
            child: Align(
              alignment: Alignment(0.8, 0.5),
              child: QueueStaticBackgroundRive(
                userInQueue: true,
                size: 200,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.lesson.name,
                                style: Theme.of(context).textTheme.headlineLarge,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start),
                            Text("${widget.lesson.startTime.toDisplayTime} - ${widget.lesson.endTime.toDisplayTime}",
                                overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      RoundedSquareButton(
                        onPressed: () {},
                        child: const Icon(Icons.remove_outlined),
                      )
                    ]),
                  ),
                  Text("Ваша позиция в очереди: 2",
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start),
                  Text(
                      "Запись от ${widget.userRecord.time.toFullDisplayTime}.${widget.userRecord.workCount != null ? " Сдано работ: ${widget.userRecord.workCount}" : ""}",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start),
                  if (expandded) SizedBox(height: 160)
                ],
              ))
        ]),
      ),
    );
  }
}
