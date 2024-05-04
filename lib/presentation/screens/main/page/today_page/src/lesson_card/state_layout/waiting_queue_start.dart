part of '../lesson_card.dart';

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
