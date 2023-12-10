import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/extension.dart';

const Map<int, String> weekdays = {
  1: 'Пн',
  2: 'Вт',
  3: 'Ср',
  4: 'Чт',
  5: 'Пт',
  6: 'Сб',
  7: 'Вс',
};

class WeeklyLessonTile extends TimeChooser {
  final Animation<double> animation;
  final List<WeeklyLessonSettingEntity> weeklyLessons;
  final int outerCount;

  const WeeklyLessonTile(this.animation, this.weeklyLessons, this.outerCount,
      {required super.innerCount, required super.onDeleteButtonPressed, required super.onTimeChanged, super.key});

  @override
  State<WeeklyLessonTile> createState() => _WeeklyLessonTileState();
}

class _WeeklyLessonTileState extends State<WeeklyLessonTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.weeklyLessons[widget.innerCount]),
        sizeFactor: widget.animation,
        child: Column(children: [
          // const Divider(thickness: 4),
          GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                        builder: (context, newSetState) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: [
                              const Gap(32),
                              Text(
                                "Редактирование еженедельного занятия",
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                              const Gap(32),
                              SegmentedButton(
                                showSelectedIcon: false,
                                multiSelectionEnabled: true,
                                segments: [1, 2, 3, 4, 5, 6, 7].map((e) => ButtonSegment(value: e, label: Text(weekdays[e] ?? ' '))).toList(),
                                selected: widget.weeklyLessons[widget.innerCount].weekday.toSet(),
                                onSelectionChanged: (value) {
                                  setState(() {
                                    // widget.onWeekDayChanged(value);
                                    widget.weeklyLessons[widget.innerCount] = widget.weeklyLessons[widget.innerCount].copyWith(weekday: value.toList());
                                  });
                                  newSetState(() {});
                                },
                              ),
                              const Gap(32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Начало",
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      const Gap(32),
                                      SizedBox(
                                        width: 104,
                                        height: 48,
                                        child: OutlinedButton(
                                            onPressed: () async {
                                              final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: widget.weeklyLessons[widget.innerCount].startTime.hour,
                                                      minute: widget.weeklyLessons[widget.innerCount].startTime.minute));

                                              if (time != null) {
                                                setState(() {
                                                  widget.onTimeChanged(time, widget.weeklyLessons[widget.innerCount].endTime);
                                                });
                                                newSetState(() {});
                                              }
                                            },
                                            child: Text(widget.weeklyLessons[widget.innerCount].startTime.toShortString())),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Конец",
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      const Gap(32),
                                      SizedBox(
                                        width: 104,
                                        height: 48,
                                        child: OutlinedButton(
                                            onPressed: () async {
                                              final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: widget.weeklyLessons[widget.innerCount].endTime.hour,
                                                      minute: widget.weeklyLessons[widget.innerCount].endTime.minute));

                                              if (time != null) {
                                                setState(() {
                                                  widget.onTimeChanged(widget.weeklyLessons[widget.innerCount].startTime, time);
                                                });
                                                newSetState(() {});
                                              }
                                            },
                                            child: Text(widget.weeklyLessons[widget.innerCount].endTime.toShortString())),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: OutlinedButton(onPressed: () => context.pop(), child: const Text('Ok')),
                              )
                            ]),
                          ),
                        ),
                      )),
              child: ColoredBox(
                color: Colors.transparent,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('  •   '),
                    Expanded(
                      child: Text(
                        widget.weeklyLessons[widget.innerCount].weekday.map((e) => weekdays[e]).toString().replaceAll('(', '').replaceAll(')', ''),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                        ": ${widget.weeklyLessons[widget.innerCount].startTime.toShortString()} - ${widget.weeklyLessons[widget.innerCount].endTime.toShortString()}"),
                    TextButton(
                        onPressed: () => widget.onDeleteButtonPressed((context.findRenderObject() as RenderBox).size.height),
                        child: const Icon(Icons.delete_outline))
                  ],
                ),
              )),
          const Divider(),
        ]));
  }
}
