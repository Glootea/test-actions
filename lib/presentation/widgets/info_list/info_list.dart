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
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: list.length + 1,
        itemBuilder: (context, count, animation) {
          if (count == list.length) {
            return AddNewTile<E>(animation, _listKey, list);
          } else {
            switch (E) {
              case Student:
                return StudentInfoTile(animation, _listKey, list as List<Student>, count);
              case LessonSettingEntity:
                return LessonInfoTile(animation, _listKey, list as List<LessonSettingEntity>, count);
              case WeeklyLessonSettingEntity:
                return WeeklyLessonTile(animation, _listKey, list as List<WeeklyLessonSettingEntity>, outerCount ?? 0, (value) {
                  list[outerCount ?? 0] = (list[outerCount ?? 0] as WeeklyLessonSettingEntity).copyWith(weekday: value.toList()) as E;
                  print((list[outerCount ?? 0] as WeeklyLessonSettingEntity).weekday);
                }, () {
                  list.removeAt(outerCount ?? 0);
                  _listKey.currentState?.removeItem(outerCount ?? 0, (context, animation) => AddNewTile(animation, _listKey, list));
                }, (value1, value2) {
                  list[outerCount ?? 0] = (list[outerCount ?? 0] as WeeklyLessonSettingEntity).copyWith(startTime: value1, endTime: value2) as E;
                });
              case DatedLessonSettingEntity:
                return DatedLessonTile(animation, _listKey, list as List<DatedLessonSettingEntity>, count, () {
                  list.removeAt(outerCount ?? 0);
                  _listKey.currentState?.removeItem(outerCount ?? 0, (context, animation) => AddNewTile(animation, _listKey, list));
                });
              default:
                Container();
            }
          }
          return Container();
        });
  }
}
