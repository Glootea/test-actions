import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/lesson.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/local_database.dart';

class InfoList<E> extends StatelessWidget {
  InfoList(
    this.list, {
    super.key,
  });

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<E> list;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: list.length + 1,
        itemBuilder: (context, count, animation) {
          if (count == list.length) {
            return AddNewTile<E>(animation, _listKey, list);
          } else {
            switch (E) {
              case Student:
                return StudentInfoTile(
                    animation, _listKey, list as List<Student>, count);

              case LessonSettingEntity:
                return LessonInfoTile(animation, _listKey,
                    list as List<LessonSettingEntity>, count);
              case WeeklyLessonSettingEntity:
                return WeeklyLessonTile(animation, _listKey,
                    list as List<WeeklyLessonSettingEntity>, count);
              default:
                Container();
              // case DatedLessonSettingEntity:
              // return DatedLessonTile(animation, _listKey,
              // list as List<DatedLessonSettingEntity>, count);
            }
          }
          return Container();
        });
  }
}

class AddNewTile<E> extends StatelessWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<E> list;
  const AddNewTile(this.animation, this._listKey, this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInOut)),
      child: Column(
        children: [
          (list.isNotEmpty) ? const Divider() : Container(),
          InkWell(
            onTap: () {
              _onAddButtonPressed();
            },
            child: ListTile(
              // Create new student field
              leading: const Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
              title: Text(
                  "Добавить ${switch (E) {
                    Student => 'студента',
                    LessonSettingEntity => 'занятие',
                    _ => 'вхождение',
                  }}",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddButtonPressed() {
    _listKey.currentState?.insertItem(
      list.length,
      duration: const Duration(milliseconds: 500),
    );
    switch (E) {
      case Student:
        list.add(Student(id: list.length, name: '') as E);
      case LessonSettingEntity:
        list.add(LessonSettingEntity('') as E);
      case WeeklyLessonSettingEntity:
        list.add(WeeklyLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0),
            const TimeOfDay(hour: 0, minute: 0), 1) as E);
      case DatedLesson:
        list.add(DatedLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0),
            const TimeOfDay(hour: 0, minute: 0), DateTime.now()) as E);
    }
  }
}

class StudentInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<Student> students;
  final int count;
  const StudentInfoTile(
      this.animation, this._listKey, this.students, this.count,
      {super.key});

  @override
  State<StudentInfoTile> createState() => _StudentInfoTileState();
}

class _StudentInfoTileState extends State<StudentInfoTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.students[widget.count]),
        sizeFactor: widget.animation,
        child: Column(
          children: [
            (widget.count != 0) ? const Divider() : Container(),
            ListTile(
              // Student field
              //TODO: create component with outer functions
              leading: Text((widget.count + 1).toString()),
              title: Row(children: [
                Expanded(
                    child: TextFormField(
                  focusNode: (widget.count == widget.students.length - 1 &&
                          widget.students[widget.count].name.isEmpty)
                      ? (FocusNode()..requestFocus())
                      : null,
                  key: UniqueKey(),
                  initialValue: widget.students[widget.count].name,
                  onChanged: (value) {
                    widget.students[widget.count] =
                        widget.students[widget.count].copyWith(name: value);
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) => value?.isEmpty ?? true
                      ? "Необходимо заполнить поле"
                      : null,
                )),
                const Gap(16),
                IconButton(
                    onPressed: () {
                      _onDeleteButtonPressed(
                          context, widget.count, widget._listKey);
                    },
                    icon: const Icon(Icons.delete_outline))
              ]),
              trailing: Switch(
                  value: widget.students[widget.count].isAdmin ?? false,
                  onChanged: (value) {
                    setState(() {
                      widget.students[widget.count] = widget
                          .students[widget.count]
                          .copyWith(isAdmin: drift.Value(value));
                    });
                  }),
            ),
          ],
        ));
  }

  void _onDeleteButtonPressed(
      BuildContext context, int count, GlobalKey<AnimatedListState> listKey) {
    listKey.currentState?.removeItem(
        count,
        (count, a) => SizeTransition(
              sizeFactor: a.drive(CurveTween(curve: Curves.easeInOut)),
              child: ListTile(
                title: Align(
                    child: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).colorScheme.error,
                )),
              ),
            ),
        duration: const Duration(milliseconds: 500));
    widget.students.removeAt(count);
    for (int i = count; i < widget.students.length; i++) {
      widget.students[i] = widget.students[i].copyWith(id: i + 1);
    }
  }
}

class LessonInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<LessonSettingEntity> lessons;
  final int count;
  const LessonInfoTile(this.animation, this._listKey, this.lessons, this.count,
      {super.key});

  @override
  State<LessonInfoTile> createState() => _LessonInfoTileState();
}

class _LessonInfoTileState extends State<LessonInfoTile> {
  final List<WeeklyLessonSettingEntity> weeklyLessons = [
    WeeklyLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0),
        const TimeOfDay(hour: 0, minute: 0), 1)
  ];
  final List<DatedLessonSettingEntity> datedLessons = [
    DatedLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0),
        const TimeOfDay(hour: 0, minute: 0), DateTime.now())
  ];
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.lessons[widget.count]),
        sizeFactor: widget.animation,
        child: ListTile(
          // Student field
          //TODO: create component with outer functions
          leading: Text((widget.count + 1).toString()),
          title: Column(
            children: [
              Row(children: [
                Expanded(
                    child: TextFormField(
                  focusNode: (widget.count == widget.lessons.length - 1 &&
                          widget.lessons[widget.count].name.isEmpty)
                      ? (FocusNode()..requestFocus())
                      : null,
                  key: UniqueKey(),
                  initialValue: widget.lessons[widget.count].name,
                  onChanged: (value) {
                    widget.lessons[widget.count] =
                        widget.lessons[widget.count].copyWith(name: value);
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) => value?.isEmpty ?? true
                      ? "Необходимо заполнить поле"
                      : null,
                )),
              ]),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Режим: "),
                  DropdownMenu(
                      initialSelection: widget.lessons[widget.count].useWeekly,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: true, label: "Еженедельно"),
                        DropdownMenuEntry(value: false, label: "Отдельные дни")
                      ],
                      onSelected: (value) => setState(() {
                            widget.lessons[widget.count] = widget
                                .lessons[widget.count]
                                .copyWith(useWeekly: value);
                          })),
                ],
              ),
              const Gap(16),
              (widget.lessons[widget.count].useWeekly)
                  ? InfoList(weeklyLessons)
                  : InfoList(datedLessons)
            ],
          ),
        ));
  }
}

class WeeklyLessonTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<WeeklyLessonSettingEntity> weeklyLessons;
  final int count;
  const WeeklyLessonTile(
      this.animation, this._listKey, this.weeklyLessons, this.count,
      {super.key});

  @override
  State<WeeklyLessonTile> createState() => _WeeklyLessonTileState();
}

class _WeeklyLessonTileState extends State<WeeklyLessonTile> {
  @override
  Widget build(BuildContext context) {
    final lesson = widget.weeklyLessons[widget.count];
    return SizeTransition(
        key: ValueKey(lesson),
        sizeFactor: widget.animation,
        child: Column(children: [
          (widget.count != 0) ? const Divider() : Container(),
          ListTile(
              // Student field
              //TODO: create component with outer functions
              leading: Text((widget.count + 1).toString()),
              title: Column(
                children: [
                  DropdownMenu(
                    initialSelection:
                        widget.weeklyLessons[widget.count].weekday,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 1, label: "Пн"),
                      DropdownMenuEntry(value: 2, label: "Вт"),
                      DropdownMenuEntry(value: 3, label: "Ср"),
                      DropdownMenuEntry(value: 4, label: "Чт"),
                      DropdownMenuEntry(value: 5, label: "Пт"),
                      DropdownMenuEntry(value: 6, label: "Сб")
                    ],
                    onSelected: (value) => setState(() {
                      widget.weeklyLessons[widget.count] = widget
                          .weeklyLessons[widget.count]
                          .copyWith(weekday: value);
                    }),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () async {
                            widget.weeklyLessons[widget.count] =
                                lesson.copyWith(
                                    startTime: await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: lesson.startTime.hour,
                                            minute: lesson.startTime.minute)));
                            setState(() {});
                          },
                          child: Text(
                              lesson.startTime ==
                                      const TimeOfDay(hour: 0, minute: 0)
                                  ? "Начало"
                                  : lesson.startTime.format(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black))),
                      OutlinedButton(
                          style: Theme.of(context).outlinedButtonTheme.style,
                          onPressed: () async {
                            widget.weeklyLessons[widget.count] =
                                lesson.copyWith(
                                    endTime: await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: lesson.endTime.hour,
                                            minute: lesson.endTime.minute)));

                            setState(() {});
                          },
                          child: Text(
                              lesson.endTime ==
                                      const TimeOfDay(hour: 0, minute: 0)
                                  ? "Конец"
                                  : lesson.endTime.format(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black))),
                    ],
                  )
                ],
              ))
        ]));
  }

  void _onDeleteButtonPressed(
      BuildContext context, int count, GlobalKey<AnimatedListState> listKey) {
    listKey.currentState?.removeItem(
        count,
        (count, a) => SizeTransition(
              sizeFactor: a.drive(CurveTween(curve: Curves.easeInOut)),
              child: ListTile(
                title: Align(
                    child: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).colorScheme.error,
                )),
              ),
            ),
        duration: const Duration(milliseconds: 500));
    widget.weeklyLessons.removeAt(count);
  }
}
