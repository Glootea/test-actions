import 'package:drift/drift.dart';

class QueueRecs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentRowNumber => integer().references(Students, #rowNumber)();
  IntColumn get subjectID => integer().references(Lessons, #id)();
  DateTimeColumn get time => dateTime()();
  TextColumn get status => text()();
  IntColumn get workCount => integer().nullable()();
}

@Deprecated("Use QueueRecs instead")
class Recs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentID => integer().references(Students, #rowNumber)();
  IntColumn get lessonID => integer().references(Lessons, #id)();
  DateTimeColumn get time => dateTime()();
  IntColumn get uploaded => integer()();
  IntColumn get workCount => integer().nullable()();
}

class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get onlineID => text()();
  BoolColumn get autoDelete => boolean()();
  BoolColumn get useWorkCount => boolean()();
  DateTimeColumn get lastDelete => dateTime().nullable()();
}

class Students extends Table {
  @override
  Set<Column> get primaryKey => {rowNumber};
  IntColumn get rowNumber => integer()();
  @Deprecated("Use rowNumber instead")
  IntColumn get id => integer()();
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

class KeyValueStorage extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {key};
}
