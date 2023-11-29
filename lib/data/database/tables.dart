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
}

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isAdmin => boolean().nullable()();
}

class WeeklyLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  IntColumn get weekDay => integer()();
}

class DatedLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
}

class UserInfo extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
}
