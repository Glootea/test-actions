import 'package:drift/drift.dart';

class Recs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userName => text()();
  TextColumn get lessonName => text().references(Lessons, #id)();
  TextColumn get time => text()();
}

class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tablename => text()();
  TextColumn get displayName => text()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  IntColumn get weekDay => integer()();
}

class UserRecs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rec => integer().references(Recs, #id)();
}
