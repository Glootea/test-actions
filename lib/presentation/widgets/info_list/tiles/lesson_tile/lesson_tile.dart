import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/presentation/widgets/info_list/info_list.dart';

class LessonInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final List<LessonSettingEntity> lessons;
  final int count;
  final void Function(double) onDeleteButtonPressed;
  const LessonInfoTile(this.animation, this.lessons, this.count, this.onDeleteButtonPressed, {super.key});

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
                            widget.onDeleteButtonPressed;
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
                        ? InfoList<WeeklyLessonSettingEntity>(weeklyLessons, outerCount: widget.count)
                        : InfoList<DatedLessonSettingEntity>(datedLessons, outerCount: widget.count),
                  ],
                ),
              ),
            ),
            const Gap(16),
          ],
        ));
  }
}
