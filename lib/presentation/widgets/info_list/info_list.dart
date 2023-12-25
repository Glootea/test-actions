import 'package:flutter/material.dart';
import 'package:queue/data/database/local_database.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/presentation/widgets/info_list/tiles/add_new_tile.dart';
import 'package:queue/presentation/widgets/info_list/tiles/lesson_tile/dated_tile.dart';
import 'package:queue/presentation/widgets/info_list/tiles/lesson_tile/lesson_tile.dart';
import 'package:queue/presentation/widgets/info_list/tiles/lesson_tile/weekly_tile.dart';
import 'package:queue/presentation/widgets/info_list/tiles/student_tile.dart';

class InfoList<E> extends StatelessWidget {
  InfoList(
    this.list, {
    this.outerCount,
    super.key,
  });

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<E> list;
  final int? outerCount;
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        physics: const NeverScrollableScrollPhysics(),
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: list.length + 1,
        itemBuilder: (context, count, animation) {
          if (count == list.length) {
            return AddNewTile<E>(animation, _listKey, list);
          } else {
            switch (E) {
              case StudentsCompanion:
                return StudentInfoTile(animation, list as List<StudentsCompanion>, count, (double height) => _onDeleteButtonPressed(count, height));
              case LessonSettingEntity:
                return LessonInfoTile(animation, list as List<LessonSettingEntity>, count, (double height) => _onDeleteButtonPressed(count, height));
              case WeeklyLessonSettingEntity:
                assert(outerCount != null);
                return WeeklyLessonTile(animation, list as List<WeeklyLessonSettingEntity>, outerCount ?? 0,
                    innerCount: count,
                    onDeleteButtonPressed: (double height) => _onDeleteButtonPressed(count, height),
                    onTimeChanged: (startTime, endTime) => _onTimeChanged<WeeklyLessonSettingEntity>(count, startTime, endTime));
              case DatedLessonSettingEntity:
                assert(outerCount != null);
                return DatedLessonTile(animation, list as List<DatedLessonSettingEntity>, outerCount ?? 0,
                    innerCount: count,
                    onDeleteButtonPressed: (double height) => _onDeleteButtonPressed(count, height),
                    onTimeChanged: (startTime, endTime) => _onTimeChanged<DatedLessonSettingEntity>(count, startTime, endTime));
              default:
                throw UnimplementedError("Unimplemented info for tile creation");
            }
          }
        });
  }

  void _onDeleteButtonPressed(int count, double height) {
    list.removeAt(count);
    _listKey.currentState?.removeItem(count, (context, animation) => _DeletedTile(height, animation), duration: Duration(milliseconds: height.toInt() * 4));
  }

  void _onTimeChanged<T extends LessonTime>(int count, TimeOfDay startTime, TimeOfDay endTime) {
    list[count] = (list[count] as T).copyWith(startTime: startTime, endTime: endTime) as E;
  }
}

class _DeletedTile extends StatelessWidget {
  final double height;
  final Animation<double> animation;
  const _DeletedTile(this.height, this.animation);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
          parent: animation,
        ),
        child: SizedBox(
          height: height,
          child: Center(
            child: Icon(Icons.delete_forever_outlined, color: Theme.of(context).colorScheme.error),
          ),
        ));
  }
}
