import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/extension.dart';
import 'package:queue/new_domain/user_cubit.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  const LessonCard(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();
    final startTime = lesson.startTime;
    final endTime = lesson.endTime;
    final queueStart = startTime.subtract(const Duration(minutes: 5));
    final now = DateTime.now();
    final isQueueNow = queueStart.isBefore(now) && now.isBefore(endTime);
    final isQueueStartSoon = now.subtract(const Duration(minutes: 5)).isAfter(queueStart);
    final isUserInQueue = lesson.userInQueue(userCubit.rowNumber);
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: switch ((isQueueNow, isQueueStartSoon, isUserInQueue)) {
          (true, _, false) => const _QueueStarted(),
          (_, true, false) => const _WaitingQueueStart(),
          (false, false, false) => _NoQueue(lesson.name, startTime, endTime),
          (_, _, true) => const _UserInQueue(),
        });
  }
}

class _WaitingQueueStart extends StatefulWidget {
  const _WaitingQueueStart();

  @override
  State<_WaitingQueueStart> createState() => _WaitingQueueStartState();
}

class _WaitingQueueStartState extends State<_WaitingQueueStart> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _NoQueue extends StatelessWidget {
  final String name;
  final DateTime startTime;
  final DateTime endTime;

  const _NoQueue(this.name, this.startTime, this.endTime);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        Text(name, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(width: 16),
        Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("${startTime.toDisplayTime} - ${endTime.toDisplayTime}")]),
      ]),
    );
  }
}

class _QueueStarted extends StatelessWidget {
  const _QueueStarted();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _UserInQueue extends StatelessWidget {
  const _UserInQueue();
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
