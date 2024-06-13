import 'package:flutter/material.dart';
import 'package:queue/entities/src/lesson_time.dart';

class LessonTimesTable extends StatelessWidget {
  const LessonTimesTable({
    required this.times,
    required this.onLessonAdded,
    required this.onLessonPressed,
    required this.onLessonDeleted,
    super.key,
  });

  final List<LessonTime> times;
  final void Function(Type lessonType) onLessonAdded;
  final void Function() onLessonPressed;
  final void Function() onLessonDeleted;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      reverse: true,
      itemCount: times.length + 1,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        if (index == times.length) {
          return _AddNewLessonTimeTile(onLessonAdded: onLessonAdded);
        }
        final time = times[index];
        if (time is WeeklyLessonEntity) {
          return _WeeklyLessonTile(
            lessonTime: time,
            onLessonPressed: () {},
            onLessonDeleted: () {},
          );
        }
        if (time is DatedLessonEntity) {
          return _DatedLessonTile(
            lessonTime: time,
            onLessonPressed: () {},
            onLessonDeleted: () {},
          );
        }
        throw UnimplementedError('Unknown lesson time type: $time');
      },
    );
  }
}

class _AddNewLessonTimeTile extends StatelessWidget {
  const _AddNewLessonTimeTile({required this.onLessonAdded});
  final void Function(Type lessonType) onLessonAdded;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: const ValueKey('NewLessonTile'),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Добавить: '),
          SizedBox(
            height: 24,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: const Text(
                      'Еженедельно',
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => onLessonAdded(WeeklyLessonEntity),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: InkWell(
                    child: const Text(
                      'Особый',
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => onLessonAdded(DatedLessonEntity),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyLessonTile extends StatelessWidget {
  const _WeeklyLessonTile({
    required this.lessonTime,
    required this.onLessonPressed,
    required this.onLessonDeleted,
  });

  final WeeklyLessonEntity lessonTime;
  final void Function() onLessonPressed;
  final void Function() onLessonDeleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: () => onLessonPressed);
  }
}

class _DatedLessonTile extends StatelessWidget {
  const _DatedLessonTile({
    required this.lessonTime,
    required this.onLessonPressed,
    required this.onLessonDeleted,
  });

  final DatedLessonEntity lessonTime;
  final void Function() onLessonPressed;
  final void Function() onLessonDeleted;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
