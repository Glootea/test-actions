part of '../lesson_card.dart';

class _QueueStarted extends StatelessWidget {
  final Lesson lesson;
  const _QueueStarted({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Positioned.fill(
          child: Align(
              alignment: Alignment(0.8, 0.5),
              child: QueueStaticBackgroundRive(
                userInQueue: false,
                size: 200,
              ))),
      Row(children: [
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
          size: 80,
          onPressed: () {},
          child: const Icon(Icons.add_outlined),
        )
      ])
    ]);
  }
}
