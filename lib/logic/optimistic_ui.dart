import 'package:queue/entities/export.dart';

class OptimisticUI {
  static List<LessonEntity> createRec(List<LessonEntity> lessons, String lessonName, DateTime time) {
    final index = lessons.indexWhere((element) => element.name == lessonName);
    List<LessonEntity> list = List.from(lessons);
    if (index != -1) {
      list.add(lessons[index].copyWith(userRec: RecEntity('Student Name', time, lessonName)));
      list.removeAt(index);
    }
    return list..sort();
  }

  static List<LessonEntity> deleteRec(List<LessonEntity> lessons, String lessonName) {
    final index = lessons.indexWhere((element) => element.name == lessonName);
    List<LessonEntity> list = List.from(lessons);
    if (index != -1) {
      list.add(lessons[index].copyWithoutUserRec());
      list.removeAt(index);
    }
    return list..sort();
  }
}
