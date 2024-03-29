import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/presentation/common_src/info_list_generic/info_list_generic.dart';

class LessonInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final List<LessonEntity> lessons;
  final int count;
  final void Function(double) onDeleteButtonPressed;
  const LessonInfoTile(this.animation, this.lessons, this.count, this.onDeleteButtonPressed, {super.key});

  @override
  State<LessonInfoTile> createState() => _LessonInfoTileState();
}

class _LessonInfoTileState extends State<LessonInfoTile> {
  bool weeklySelected = true;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.lessons[widget.count]),
        sizeFactor: CurvedAnimation(
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
          parent: widget.animation,
        ),
        child:
            // Student field
            //TODO: create component with outer functions

            Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue:
                                widget.lessons[widget.count].name.isEmpty ? null : widget.lessons[widget.count].name,
                            onChanged: (value) =>
                                widget.lessons[widget.count] = widget.lessons[widget.count].copyWith(name: value),
                            decoration: const InputDecoration(hintText: "Название занятия"),
                            validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
                            autovalidateMode: AutovalidateMode.always,
                            focusNode:
                                (widget.count == widget.lessons.length - 1 && widget.lessons[widget.count].name.isEmpty)
                                    ? (FocusNode()..requestFocus())
                                    : null,
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        const Gap(16),
                        OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).colorScheme.error)),
                          ),
                          onPressed: () {
                            widget.onDeleteButtonPressed((context.findRenderObject() as RenderBox).size.height);
                          },
                          child: Icon(Icons.delete_forever_outlined, color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Expanded(child: Text("Учитывать количество работ при составлении очереди?")),
                      Switch(
                          value: widget.lessons[widget.count].useWorkCount,
                          onChanged: (value) => setState(() {
                                widget.lessons[widget.count] =
                                    widget.lessons[widget.count].copyWith(useWorkCount: value);
                              }))
                    ]),
                    const Gap(16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Expanded(child: Text("Удалять историю очереди после каждого занятия?")),
                      Switch(
                          value: widget.lessons[widget.count].autoDelete,
                          onChanged: (value) => setState(() {
                                widget.lessons[widget.count] = widget.lessons[widget.count].copyWith(autoDelete: value);
                              }))
                    ]),
                    const Gap(16),
                    const Text("Выберите режим добавления нового времени: "),
                    const Gap(16),
                    SegmentedButton(
                      segments: const [
                        ButtonSegment(value: true, label: Text('Еженедельно')),
                        ButtonSegment(value: false, label: Text('Дни'))
                      ],
                      showSelectedIcon: false,
                      selected: {weeklySelected},
                      onSelectionChanged: (value) => setState(() {
                        weeklySelected = value.first;
                      }),
                    ),
                    const Gap(16),
                    InfoList<LessonTime>(
                      widget.lessons[widget.count].lessonTimes,
                      outerCount: widget.count,
                      weeklySelected: weeklySelected,
                    )
                  ],
                ),
              ),
            ),
            const Gap(16),
          ],
        ));
  }
}
