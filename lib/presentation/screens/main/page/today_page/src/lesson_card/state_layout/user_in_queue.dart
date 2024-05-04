part of '../lesson_card.dart';

class _UserInQueue extends StatefulWidget {
  final Lesson lesson;
  final NewQueueRecord userRecord;
  const _UserInQueue({required this.lesson, required this.userRecord});

  @override
  State<_UserInQueue> createState() => _UserInQueueState();
}

class _UserInQueueState extends State<_UserInQueue> {
  bool expandded = false;
  final StreamController<bool> streamController = StreamController();
  late final Stream<bool> actionStream = streamController.stream;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        streamController.add(expandded);
        expandded = !expandded;
      }),
      child: AnimatedSize(
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          height: expandded ? null : 148,
          child: Stack(alignment: Alignment.topCenter, children: [
            Positioned(
              right: MediaQuery.sizeOf(context).width / 10,
              child: QueueStaticBackgroundRive(
                userInQueue: true,
                size: 200,
                actionStream: actionStream,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
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
                      const Gap(8),
                      RoundedSquareButton(
                        size: 64,
                        onPressed: () {},
                        child: const Icon(Icons.remove_outlined),
                      ),
                    ]),
                    const Divider(),
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
      ),
    );
  }
}
