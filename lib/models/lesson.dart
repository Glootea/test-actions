import 'package:queue/models/rec.dart';

import '../data/lesson_database.dart';

class Lesson {
  final String displayName;
  final String tableName;
  final int weekDay;
  final List<bool> weeks;
  final LessonPair pair;
  List<Rec> recs = [];
  UserRec? userRec;

  Lesson(this.displayName, this.tableName, this.weekDay, this.weeks, this.pair,
      [this.userRec]);
}
