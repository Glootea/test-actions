import 'package:queue/entities/export.dart';

/// Used to show ui updates faster that web request comes through. Displays result of successful operation
class OptimisticUI {
  static List<LessonDisplayedEntity> createRec(List<LessonDisplayedEntity> lessons, String lessonName, DateTime time) {
    final index = lessons.indexWhere((element) => element.name == lessonName);
    List<LessonDisplayedEntity> list = List.from(lessons);
    if (index != -1) {
      list.add(lessons[index].copyWith(userRec: RecEntity('Student Name', time, lessonName)));
      list.removeAt(index);
    }
    return list..sort();
  }

  static List<LessonDisplayedEntity> deleteRec(List<LessonDisplayedEntity> lessons, String lessonName) {
    final index = lessons.indexWhere((element) => element.name == lessonName);
    List<LessonDisplayedEntity> list = List.from(lessons);
    if (index != -1) {
      list.add(lessons[index].copyWithoutUserRec());
      list.removeAt(index);
    }
    return list..sort();
  }
}
