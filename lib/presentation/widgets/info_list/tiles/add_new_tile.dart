import 'package:flutter/material.dart';
import 'package:queue/data/database/local_database.dart';
import 'package:queue/entities/lesson.dart';

class AddNewTile<E> extends StatelessWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<E> list;
  const AddNewTile(this.animation, this._listKey, this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
        parent: animation,
      ),
      child: Column(
        children: [
          // (list.isNotEmpty) ? const Divider() : Container(),
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
                    WeeklyLessonSettingEntity => 'время, которое повторяется каждую неделю',
                    DatedLessonSettingEntity => 'время, которое повторяется в определенные дни',
                    _ => 'вариант, который никто не увидит'
                  }}",
                  style: (E == LessonSettingEntity || E == Student) ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyMedium),
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
        list.add(WeeklyLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0), [1]) as E);
      case DatedLessonSettingEntity:
        list.add(DatedLessonSettingEntity(const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0), [
          DateTime.now(),
        ]) as E);
    }
  }
}
