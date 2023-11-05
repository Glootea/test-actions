import 'package:drift/drift.dart';

class Recs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentID => integer().references(Students, #id)();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  DateTimeColumn get time => dateTime()();
  BoolColumn get uploaded => boolean().nullable()();
}

class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  IntColumn get weekDay => integer()();
}

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class DatedLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  DateTimeColumn get date => dateTime()();
}
