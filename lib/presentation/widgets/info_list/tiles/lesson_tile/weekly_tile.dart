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

class WeeklyLessonTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<WeeklyLessonSettingEntity> weeklyLessons;
  final int weeklyLessonIndex;
  final void Function(Set<int>) onWeekDayChanged;
  final void Function() onDeleteButtonPressed;
  final void Function(TimeOfDay, TimeOfDay) onTimeChanged;
  const WeeklyLessonTile(
      this.animation, this._listKey, this.weeklyLessons, this.weeklyLessonIndex, this.onWeekDayChanged, this.onDeleteButtonPressed, this.onTimeChanged,
      {super.key});

  @override
  State<WeeklyLessonTile> createState() => _WeeklyLessonTileState();
}

class _WeeklyLessonTileState extends State<WeeklyLessonTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.weeklyLessons[widget.weeklyLessonIndex]),
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
                                selected: widget.weeklyLessons[widget.weeklyLessonIndex].weekday.toSet(),
                                onSelectionChanged: (value) {
                                  setState(() {
                                    widget.onWeekDayChanged(value);
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
                                                      hour: widget.weeklyLessons[widget.weeklyLessonIndex].startTime.hour,
                                                      minute: widget.weeklyLessons[widget.weeklyLessonIndex].startTime.minute));

                                              if (time != null) {
                                                setState(() {
                                                  widget.onTimeChanged(time, widget.weeklyLessons[widget.weeklyLessonIndex].endTime);
                                                });
                                                newSetState(() {});
                                              }
                                            },
                                            child: Text(widget.weeklyLessons[widget.weeklyLessonIndex].startTime.toShortString())),
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
                                                      hour: widget.weeklyLessons[widget.weeklyLessonIndex].endTime.hour,
                                                      minute: widget.weeklyLessons[widget.weeklyLessonIndex].endTime.minute));

                                              if (time != null) {
                                                setState(() {
                                                  widget.onTimeChanged(widget.weeklyLessons[widget.weeklyLessonIndex].startTime, time);
                                                });
                                                newSetState(() {});
                                              }
                                            },
                                            child: Text(widget.weeklyLessons[widget.weeklyLessonIndex].endTime.toShortString())),
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
                        widget.weeklyLessons[widget.weeklyLessonIndex].weekday.map((e) => weekdays[e]).toString().replaceAll('(', '').replaceAll(')', ''),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    Text(
                        ": ${widget.weeklyLessons[widget.weeklyLessonIndex].startTime.toShortString()} - ${widget.weeklyLessons[widget.weeklyLessonIndex].endTime.toShortString()}"),
                    TextButton(onPressed: widget.onDeleteButtonPressed, child: const Icon(Icons.delete_outline))
                  ],
                ),
              )),
          const Divider(),
        ]));
  }
}
