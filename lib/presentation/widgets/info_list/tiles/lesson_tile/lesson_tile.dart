import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/presentation/widgets/info_list/info_list.dart';
import 'package:queue/presentation/widgets/info_list/tiles/add_new_tile.dart';

class LessonInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<LessonSettingEntity> lessons;
  final int count;
  const LessonInfoTile(this.animation, this._listKey, this.lessons, this.count, {super.key});

  @override
  State<LessonInfoTile> createState() => _LessonInfoTileState();
}

class _LessonInfoTileState extends State<LessonInfoTile> {
  final List<WeeklyLessonSettingEntity> weeklyLessons = [
    WeeklyLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0), [1])
  ];
  final List<DatedLessonSettingEntity> datedLessons = [
    DatedLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0), [DateTime.now()])
  ];
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.lessons[widget.count]),
        sizeFactor: widget.animation,
        child:
            // Student field
            //TODO: create component with outer functions

            Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.lessons[widget.count].name,
                            onChanged: (value) => widget.lessons[widget.count] = widget.lessons[widget.count].copyWith(name: value),
                            decoration: const InputDecoration(hintText: "Название занятия"),
                          ),
                        ),
                        const Gap(16),
                        OutlinedButton(
                          child: const Icon(Icons.delete_forever_outlined),
                          onPressed: () {
                            widget.lessons.removeAt(widget.count);
                            widget._listKey.currentState
                                ?.removeItem(widget.count, (context, animation) => AddNewTile(animation, widget._listKey, widget.lessons));
                          },
                        ),
                      ],
                    ),
                    const Gap(16),
                    SegmentedButton(
                      segments: const [ButtonSegment(value: true, label: Text('Еженедельно')), ButtonSegment(value: false, label: Text('Дни'))],
                      showSelectedIcon: false,
                      selected: {widget.lessons[widget.count].useWeekly},
                      onSelectionChanged: (value) => setState(() {
                        print(value);
                        widget.lessons[widget.count] = widget.lessons[widget.count].copyWith(useWeekly: value.first);
                      }),
                    ),
                    const Gap(16),
                    widget.lessons[widget.count].useWeekly
                        ? InfoList<WeeklyLessonSettingEntity>(weeklyLessons)
                        : InfoList<DatedLessonSettingEntity>(datedLessons),
                  ],
                ),
              ),
            ),
            const Gap(16),
          ],
        ));
  }
}
