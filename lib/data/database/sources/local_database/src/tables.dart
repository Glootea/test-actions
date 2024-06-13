import 'package:drift/drift.dart';

class QueueRecs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentRowNumber => integer().references(Students, #id)();
  IntColumn get subjectID => integer().references(Subject, #id)();
  DateTimeColumn get time => dateTime()();
  TextColumn get status => text()();
  IntColumn get workCount => integer().nullable()();
}

class Subject extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get onlineID => text()();
  BoolColumn get autoDelete => boolean()();
  BoolColumn get useWorkCount => boolean()();
  DateTimeColumn get lastDelete => dateTime().nullable()();
}

class Students extends Table {
  @override
  Set<Column> get primaryKey => {id};
  IntColumn get id => integer()();
  TextColumn get name => text()();
  BoolColumn get isAdmin => boolean().nullable()();
}

class WeeklyLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonID => integer().references(Subject, #id)();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  IntColumn get weekDay => integer()();
}

class DatedLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get lessonID => integer().references(Subject, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
}

class KeyValueStorageTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {key};
}

class Attendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectID => integer()();
  DateTimeColumn get lessonStart => dateTime()();
  DateTimeColumn get dateCreated => dateTime()();
  TextColumn get status => text()();
}
