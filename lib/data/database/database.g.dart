// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LessonsTable extends Lessons with TableInfo<$LessonsTable, Lesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tablenameMeta =
      const VerificationMeta('tablename');
  @override
  late final GeneratedColumn<String> tablename = GeneratedColumn<String>(
      'tablename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'end_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekDayMeta =
      const VerificationMeta('weekDay');
  @override
  late final GeneratedColumn<int> weekDay = GeneratedColumn<int>(
      'week_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tablename, displayName, startTime, endTime, weekDay];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lessons';
  @override
  VerificationContext validateIntegrity(Insertable<Lesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tablename')) {
      context.handle(_tablenameMeta,
          tablename.isAcceptableOrUnknown(data['tablename']!, _tablenameMeta));
    } else if (isInserting) {
      context.missing(_tablenameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('week_day')) {
      context.handle(_weekDayMeta,
          weekDay.isAcceptableOrUnknown(data['week_day']!, _weekDayMeta));
    } else if (isInserting) {
      context.missing(_weekDayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tablename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tablename'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time'])!,
      weekDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_day'])!,
    );
  }

  @override
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class Lesson extends DataClass implements Insertable<Lesson> {
  final int id;
  final String tablename;
  final String displayName;
  final String startTime;
  final String endTime;
  final int weekDay;
  const Lesson(
      {required this.id,
      required this.tablename,
      required this.displayName,
      required this.startTime,
      required this.endTime,
      required this.weekDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tablename'] = Variable<String>(tablename);
    map['display_name'] = Variable<String>(displayName);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['week_day'] = Variable<int>(weekDay);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      tablename: Value(tablename),
      displayName: Value(displayName),
      startTime: Value(startTime),
      endTime: Value(endTime),
      weekDay: Value(weekDay),
    );
  }

  factory Lesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<int>(json['id']),
      tablename: serializer.fromJson<String>(json['tablename']),
      displayName: serializer.fromJson<String>(json['displayName']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      weekDay: serializer.fromJson<int>(json['weekDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tablename': serializer.toJson<String>(tablename),
      'displayName': serializer.toJson<String>(displayName),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'weekDay': serializer.toJson<int>(weekDay),
    };
  }

  Lesson copyWith(
          {int? id,
          String? tablename,
          String? displayName,
          String? startTime,
          String? endTime,
          int? weekDay}) =>
      Lesson(
        id: id ?? this.id,
        tablename: tablename ?? this.tablename,
        displayName: displayName ?? this.displayName,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        weekDay: weekDay ?? this.weekDay,
      );
  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('tablename: $tablename, ')
          ..write('displayName: $displayName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weekDay: $weekDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tablename, displayName, startTime, endTime, weekDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.tablename == this.tablename &&
          other.displayName == this.displayName &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.weekDay == this.weekDay);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<int> id;
  final Value<String> tablename;
  final Value<String> displayName;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<int> weekDay;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.tablename = const Value.absent(),
    this.displayName = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weekDay = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String tablename,
    required String displayName,
    required String startTime,
    required String endTime,
    required int weekDay,
  })  : tablename = Value(tablename),
        displayName = Value(displayName),
        startTime = Value(startTime),
        endTime = Value(endTime),
        weekDay = Value(weekDay);
  static Insertable<Lesson> custom({
    Expression<int>? id,
    Expression<String>? tablename,
    Expression<String>? displayName,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? weekDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tablename != null) 'tablename': tablename,
      if (displayName != null) 'display_name': displayName,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (weekDay != null) 'week_day': weekDay,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? tablename,
      Value<String>? displayName,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<int>? weekDay}) {
    return LessonsCompanion(
      id: id ?? this.id,
      tablename: tablename ?? this.tablename,
      displayName: displayName ?? this.displayName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      weekDay: weekDay ?? this.weekDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tablename.present) {
      map['tablename'] = Variable<String>(tablename.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (weekDay.present) {
      map['week_day'] = Variable<int>(weekDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('tablename: $tablename, ')
          ..write('displayName: $displayName, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weekDay: $weekDay')
          ..write(')'))
        .toString();
  }
}

class $RecsTable extends Recs with TableInfo<$RecsTable, Rec> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonNameMeta =
      const VerificationMeta('lessonName');
  @override
  late final GeneratedColumn<String> lessonName = GeneratedColumn<String>(
      'lesson_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lessons (id)'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userName, lessonName, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recs';
  @override
  VerificationContext validateIntegrity(Insertable<Rec> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('lesson_name')) {
      context.handle(
          _lessonNameMeta,
          lessonName.isAcceptableOrUnknown(
              data['lesson_name']!, _lessonNameMeta));
    } else if (isInserting) {
      context.missing(_lessonNameMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rec map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rec(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      lessonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_name'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $RecsTable createAlias(String alias) {
    return $RecsTable(attachedDatabase, alias);
  }
}

class Rec extends DataClass implements Insertable<Rec> {
  final int id;
  final String userName;
  final String lessonName;
  final String time;
  const Rec(
      {required this.id,
      required this.userName,
      required this.lessonName,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['lesson_name'] = Variable<String>(lessonName);
    map['time'] = Variable<String>(time);
    return map;
  }

  RecsCompanion toCompanion(bool nullToAbsent) {
    return RecsCompanion(
      id: Value(id),
      userName: Value(userName),
      lessonName: Value(lessonName),
      time: Value(time),
    );
  }

  factory Rec.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rec(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      lessonName: serializer.fromJson<String>(json['lessonName']),
      time: serializer.fromJson<String>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'lessonName': serializer.toJson<String>(lessonName),
      'time': serializer.toJson<String>(time),
    };
  }

  Rec copyWith({int? id, String? userName, String? lessonName, String? time}) =>
      Rec(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        lessonName: lessonName ?? this.lessonName,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('Rec(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('lessonName: $lessonName, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userName, lessonName, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rec &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.lessonName == this.lessonName &&
          other.time == this.time);
}

class RecsCompanion extends UpdateCompanion<Rec> {
  final Value<int> id;
  final Value<String> userName;
  final Value<String> lessonName;
  final Value<String> time;
  const RecsCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.lessonName = const Value.absent(),
    this.time = const Value.absent(),
  });
  RecsCompanion.insert({
    this.id = const Value.absent(),
    required String userName,
    required String lessonName,
    required String time,
  })  : userName = Value(userName),
        lessonName = Value(lessonName),
        time = Value(time);
  static Insertable<Rec> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<String>? lessonName,
    Expression<String>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (lessonName != null) 'lesson_name': lessonName,
      if (time != null) 'time': time,
    });
  }

  RecsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userName,
      Value<String>? lessonName,
      Value<String>? time}) {
    return RecsCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      lessonName: lessonName ?? this.lessonName,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (lessonName.present) {
      map['lesson_name'] = Variable<String>(lessonName.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecsCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('lessonName: $lessonName, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $UserRecsTable extends UserRecs with TableInfo<$UserRecsTable, UserRec> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRecsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _recMeta = const VerificationMeta('rec');
  @override
  late final GeneratedColumn<int> rec = GeneratedColumn<int>(
      'rec', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES recs (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, rec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_recs';
  @override
  VerificationContext validateIntegrity(Insertable<UserRec> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rec')) {
      context.handle(
          _recMeta, rec.isAcceptableOrUnknown(data['rec']!, _recMeta));
    } else if (isInserting) {
      context.missing(_recMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRec map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRec(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rec'])!,
    );
  }

  @override
  $UserRecsTable createAlias(String alias) {
    return $UserRecsTable(attachedDatabase, alias);
  }
}

class UserRec extends DataClass implements Insertable<UserRec> {
  final int id;
  final int rec;
  const UserRec({required this.id, required this.rec});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rec'] = Variable<int>(rec);
    return map;
  }

  UserRecsCompanion toCompanion(bool nullToAbsent) {
    return UserRecsCompanion(
      id: Value(id),
      rec: Value(rec),
    );
  }

  factory UserRec.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRec(
      id: serializer.fromJson<int>(json['id']),
      rec: serializer.fromJson<int>(json['rec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rec': serializer.toJson<int>(rec),
    };
  }

  UserRec copyWith({int? id, int? rec}) => UserRec(
        id: id ?? this.id,
        rec: rec ?? this.rec,
      );
  @override
  String toString() {
    return (StringBuffer('UserRec(')
          ..write('id: $id, ')
          ..write('rec: $rec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRec && other.id == this.id && other.rec == this.rec);
}

class UserRecsCompanion extends UpdateCompanion<UserRec> {
  final Value<int> id;
  final Value<int> rec;
  const UserRecsCompanion({
    this.id = const Value.absent(),
    this.rec = const Value.absent(),
  });
  UserRecsCompanion.insert({
    this.id = const Value.absent(),
    required int rec,
  }) : rec = Value(rec);
  static Insertable<UserRec> custom({
    Expression<int>? id,
    Expression<int>? rec,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rec != null) 'rec': rec,
    });
  }

  UserRecsCompanion copyWith({Value<int>? id, Value<int>? rec}) {
    return UserRecsCompanion(
      id: id ?? this.id,
      rec: rec ?? this.rec,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rec.present) {
      map['rec'] = Variable<int>(rec.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRecsCompanion(')
          ..write('id: $id, ')
          ..write('rec: $rec')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $RecsTable recs = $RecsTable(this);
  late final $UserRecsTable userRecs = $UserRecsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [lessons, recs, userRecs];
}
