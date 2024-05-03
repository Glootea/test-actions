part of '../lesson_card.dart';

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
