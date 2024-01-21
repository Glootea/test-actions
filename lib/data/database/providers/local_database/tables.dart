import 'package:drift/drift.dart';

class Recs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentID => integer().references(Students, #id)();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  DateTimeColumn get time => dateTime()();

  /// 1 - uploaded; 0 - not uploaded, but should be; -1 - should be deleted
  IntColumn get uploaded => integer()();
}

class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get onlineID => text()();
}

class Students extends Table {
  @override
  Set<Column> get primaryKey => {id};
  IntColumn get id => integer()(); // TODO: merge id and onlineTableRowNumber
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
  @override
  Set<Column> get primaryKey => {key};
}
