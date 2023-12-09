import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/widgets/info_list/tiles/student_tile.dart';

class DatedLessonTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> listKey;
  final List<DatedLessonSettingEntity> datedLessons;
  final int count;
  final Function onDeleteButtonPressed;
  const DatedLessonTile(this.animation, this.listKey, this.datedLessons, this.count, this.onDeleteButtonPressed, {super.key});

  @override
  State<DatedLessonTile> createState() => _DatedLessonTileTileState();
}

class _DatedLessonTileTileState extends State<DatedLessonTile> {
  DateTime? lastSelectedDate;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      key: ValueKey(widget.datedLessons[widget.count]),
      sizeFactor: widget.animation,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Создание времени занятий в отдельные дни"),
                      content: StatefulBuilder(
                        builder: (context, newSetState) => Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                          SizedBox(
                              width: double.maxFinite,
                              height: 400,
                              child: GridView.builder(
                                  itemCount: widget.datedLessons[widget.count].date.length + 1,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).size.width ~/ 120),
                                  itemBuilder: (context, count) => (count == widget.datedLessons[widget.count].date.length)
                                      ? SizedBox(
                                          height: 48,
                                          width: 64,
                                          child: Center(
                                            child: OutlinedButton(
                                                onPressed: () async {
                                                  final result = await showDatePicker(
                                                      locale: const Locale('ru', 'RU'),
                                                      context: context,
                                                      firstDate: DateTime.now(),
                                                      initialDate: lastSelectedDate,
                                                      lastDate: DateTime.now().add(const Duration(days: 365)));
                                                  lastSelectedDate = result;
                                                  if (result != null) {
                                                    setState(() {
                                                      widget.datedLessons[widget.count].date.add(result);
                                                    });
                                                    newSetState(() {});
                                                  }
                                                },
                                                child: const Text('+')),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 48,
                                          width: 64,
                                          child: Center(
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                final result = await showDatePicker(
                                                    locale: const Locale('ru', 'RU'),
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    initialDate: lastSelectedDate,
                                                    lastDate: DateTime.now().add(const Duration(days: 365)));
                                                lastSelectedDate = result;
                                                if (result != null) {
                                                  setState(() {
                                                    widget.datedLessons[widget.count].date[count] = result;
                                                  });
                                                  newSetState(() {});
                                                }
                                              },
                                              child: Text(
                                                DateFormat('dd.MM').format(widget.datedLessons[widget.count].date[count]),
                                                maxLines: 1,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          )))),
                          const Gap(16),
                          SizedBox(
                            height: 96,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Начало',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const Gap(16),
                                    OutlinedButton(
                                      onPressed: () async {
                                        widget.datedLessons[widget.count] = widget.datedLessons[widget.count].copyWith(
                                            startTime: await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: widget.datedLessons[widget.count].startTime.hour,
                                                    minute: widget.datedLessons[widget.count].startTime.minute)));
                                        setState(() {});
                                        newSetState(() {});
                                      },
                                      child: Text(widget.datedLessons[widget.count].startTime.toShortString()),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Конец',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const Gap(16),
                                    OutlinedButton(
                                      onPressed: () async {
                                        widget.datedLessons[widget.count] = widget.datedLessons[widget.count].copyWith(
                                            endTime: await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: widget.datedLessons[widget.count].endTime.hour,
                                                    minute: widget.datedLessons[widget.count].endTime.minute)));
                                        setState(() {});
                                        newSetState(() {});
                                      },
                                      child: Text(widget.datedLessons[widget.count].endTime.toShortString()),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.listKey.currentState?.removeItem(widget.count, (context, animation) => RemovedItemFromInfoList(animation),
                                duration: const Duration(milliseconds: 500));
                            widget.datedLessons[widget.count].date.removeAt(widget.count);
                            context.pop();
                          },
                          child: const Text("Удалить"),
                        ),
                        TextButton(onPressed: () => context.pop(), child: const Text('OK'))
                      ],
                    )),
            child: ColoredBox(
              color: Colors.transparent,
              child: Row(
                children: [
                  const Text('  •   '),
                  Expanded(
                    child: Text(
                      '${widget.datedLessons[widget.count].date.map((e) => DateFormat('dd.MM').format(e))}'.replaceAll('(', '').replaceAll(')', ''),
                      maxLines: null,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(' ${widget.datedLessons[widget.count].startTime.toShortString()} - ${widget.datedLessons[widget.count].endTime.toShortString()}'),
                  TextButton(onPressed: () => widget.onDeleteButtonPressed, child: const Icon(Icons.delete_outline))
                ],
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
