// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  const Student({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Student copyWith({int? id, String? name}) => Student(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student && other.id == this.id && other.name == this.name);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  StudentsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [id, name, startTime, endTime, weekDay];
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
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
  final String name;
  final String startTime;
  final String endTime;
  final int weekDay;
  const Lesson(
      {required this.id,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.weekDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['week_day'] = Variable<int>(weekDay);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      name: Value(name),
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
      name: serializer.fromJson<String>(json['name']),
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
      'name': serializer.toJson<String>(name),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'weekDay': serializer.toJson<int>(weekDay),
    };
  }

  Lesson copyWith(
          {int? id,
          String? name,
          String? startTime,
          String? endTime,
          int? weekDay}) =>
      Lesson(
        id: id ?? this.id,
        name: name ?? this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        weekDay: weekDay ?? this.weekDay,
      );
  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weekDay: $weekDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startTime, endTime, weekDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.name == this.name &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.weekDay == this.weekDay);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<int> weekDay;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weekDay = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String startTime,
    required String endTime,
    required int weekDay,
  })  : name = Value(name),
        startTime = Value(startTime),
        endTime = Value(endTime),
        weekDay = Value(weekDay);
  static Insertable<Lesson> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? weekDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (weekDay != null) 'week_day': weekDay,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<int>? weekDay}) {
    return LessonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
          ..write('name: $name, ')
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
  static const VerificationMeta _studentIDMeta =
      const VerificationMeta('studentID');
  @override
  late final GeneratedColumn<int> studentID = GeneratedColumn<int>(
      'student_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _lessonIDMeta =
      const VerificationMeta('lessonID');
  @override
  late final GeneratedColumn<int> lessonID = GeneratedColumn<int>(
      'lesson_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lessons (id)'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedMeta =
      const VerificationMeta('uploaded');
  @override
  late final GeneratedColumn<bool> uploaded = GeneratedColumn<bool>(
      'uploaded', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("uploaded" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, studentID, lessonID, time, uploaded];
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
    if (data.containsKey('student_i_d')) {
      context.handle(
          _studentIDMeta,
          studentID.isAcceptableOrUnknown(
              data['student_i_d']!, _studentIDMeta));
    } else if (isInserting) {
      context.missing(_studentIDMeta);
    }
    if (data.containsKey('lesson_i_d')) {
      context.handle(_lessonIDMeta,
          lessonID.isAcceptableOrUnknown(data['lesson_i_d']!, _lessonIDMeta));
    } else if (isInserting) {
      context.missing(_lessonIDMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('uploaded')) {
      context.handle(_uploadedMeta,
          uploaded.isAcceptableOrUnknown(data['uploaded']!, _uploadedMeta));
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
      studentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_i_d'])!,
      lessonID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_i_d'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      uploaded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}uploaded']),
    );
  }

  @override
  $RecsTable createAlias(String alias) {
    return $RecsTable(attachedDatabase, alias);
  }
}

class Rec extends DataClass implements Insertable<Rec> {
  final int id;
  final int studentID;
  final int lessonID;
  final DateTime time;
  final bool? uploaded;
  const Rec(
      {required this.id,
      required this.studentID,
      required this.lessonID,
      required this.time,
      this.uploaded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_i_d'] = Variable<int>(studentID);
    map['lesson_i_d'] = Variable<int>(lessonID);
    map['time'] = Variable<DateTime>(time);
    if (!nullToAbsent || uploaded != null) {
      map['uploaded'] = Variable<bool>(uploaded);
    }
    return map;
  }

  RecsCompanion toCompanion(bool nullToAbsent) {
    return RecsCompanion(
      id: Value(id),
      studentID: Value(studentID),
      lessonID: Value(lessonID),
      time: Value(time),
      uploaded: uploaded == null && nullToAbsent
          ? const Value.absent()
          : Value(uploaded),
    );
  }

  factory Rec.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rec(
      id: serializer.fromJson<int>(json['id']),
      studentID: serializer.fromJson<int>(json['studentID']),
      lessonID: serializer.fromJson<int>(json['lessonID']),
      time: serializer.fromJson<DateTime>(json['time']),
      uploaded: serializer.fromJson<bool?>(json['uploaded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentID': serializer.toJson<int>(studentID),
      'lessonID': serializer.toJson<int>(lessonID),
      'time': serializer.toJson<DateTime>(time),
      'uploaded': serializer.toJson<bool?>(uploaded),
    };
  }

  Rec copyWith(
          {int? id,
          int? studentID,
          int? lessonID,
          DateTime? time,
          Value<bool?> uploaded = const Value.absent()}) =>
      Rec(
        id: id ?? this.id,
        studentID: studentID ?? this.studentID,
        lessonID: lessonID ?? this.lessonID,
        time: time ?? this.time,
        uploaded: uploaded.present ? uploaded.value : this.uploaded,
      );
  @override
  String toString() {
    return (StringBuffer('Rec(')
          ..write('id: $id, ')
          ..write('studentID: $studentID, ')
          ..write('lessonID: $lessonID, ')
          ..write('time: $time, ')
          ..write('uploaded: $uploaded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, studentID, lessonID, time, uploaded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rec &&
          other.id == this.id &&
          other.studentID == this.studentID &&
          other.lessonID == this.lessonID &&
          other.time == this.time &&
          other.uploaded == this.uploaded);
}

class RecsCompanion extends UpdateCompanion<Rec> {
  final Value<int> id;
  final Value<int> studentID;
  final Value<int> lessonID;
  final Value<DateTime> time;
  final Value<bool?> uploaded;
  const RecsCompanion({
    this.id = const Value.absent(),
    this.studentID = const Value.absent(),
    this.lessonID = const Value.absent(),
    this.time = const Value.absent(),
    this.uploaded = const Value.absent(),
  });
  RecsCompanion.insert({
    this.id = const Value.absent(),
    required int studentID,
    required int lessonID,
    required DateTime time,
    this.uploaded = const Value.absent(),
  })  : studentID = Value(studentID),
        lessonID = Value(lessonID),
        time = Value(time);
  static Insertable<Rec> custom({
    Expression<int>? id,
    Expression<int>? studentID,
    Expression<int>? lessonID,
    Expression<DateTime>? time,
    Expression<bool>? uploaded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentID != null) 'student_i_d': studentID,
      if (lessonID != null) 'lesson_i_d': lessonID,
      if (time != null) 'time': time,
      if (uploaded != null) 'uploaded': uploaded,
    });
  }

  RecsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentID,
      Value<int>? lessonID,
      Value<DateTime>? time,
      Value<bool?>? uploaded}) {
    return RecsCompanion(
      id: id ?? this.id,
      studentID: studentID ?? this.studentID,
      lessonID: lessonID ?? this.lessonID,
      time: time ?? this.time,
      uploaded: uploaded ?? this.uploaded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentID.present) {
      map['student_i_d'] = Variable<int>(studentID.value);
    }
    if (lessonID.present) {
      map['lesson_i_d'] = Variable<int>(lessonID.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (uploaded.present) {
      map['uploaded'] = Variable<bool>(uploaded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecsCompanion(')
          ..write('id: $id, ')
          ..write('studentID: $studentID, ')
          ..write('lessonID: $lessonID, ')
          ..write('time: $time, ')
          ..write('uploaded: $uploaded')
          ..write(')'))
        .toString();
  }
}

class $DatedLessonsTable extends DatedLessons
    with TableInfo<$DatedLessonsTable, DatedLesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatedLessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lessonIDMeta =
      const VerificationMeta('lessonID');
  @override
  late final GeneratedColumn<int> lessonID = GeneratedColumn<int>(
      'lesson_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lessons (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, lessonID, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dated_lessons';
  @override
  VerificationContext validateIntegrity(Insertable<DatedLesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lesson_i_d')) {
      context.handle(_lessonIDMeta,
          lessonID.isAcceptableOrUnknown(data['lesson_i_d']!, _lessonIDMeta));
    } else if (isInserting) {
      context.missing(_lessonIDMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatedLesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatedLesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lessonID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_i_d'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $DatedLessonsTable createAlias(String alias) {
    return $DatedLessonsTable(attachedDatabase, alias);
  }
}

class DatedLesson extends DataClass implements Insertable<DatedLesson> {
  final int id;
  final int lessonID;
  final DateTime date;
  const DatedLesson(
      {required this.id, required this.lessonID, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_i_d'] = Variable<int>(lessonID);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DatedLessonsCompanion toCompanion(bool nullToAbsent) {
    return DatedLessonsCompanion(
      id: Value(id),
      lessonID: Value(lessonID),
      date: Value(date),
    );
  }

  factory DatedLesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatedLesson(
      id: serializer.fromJson<int>(json['id']),
      lessonID: serializer.fromJson<int>(json['lessonID']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonID': serializer.toJson<int>(lessonID),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  DatedLesson copyWith({int? id, int? lessonID, DateTime? date}) => DatedLesson(
        id: id ?? this.id,
        lessonID: lessonID ?? this.lessonID,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('DatedLesson(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonID, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatedLesson &&
          other.id == this.id &&
          other.lessonID == this.lessonID &&
          other.date == this.date);
}

class DatedLessonsCompanion extends UpdateCompanion<DatedLesson> {
  final Value<int> id;
  final Value<int> lessonID;
  final Value<DateTime> date;
  const DatedLessonsCompanion({
    this.id = const Value.absent(),
    this.lessonID = const Value.absent(),
    this.date = const Value.absent(),
  });
  DatedLessonsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonID,
    required DateTime date,
  })  : lessonID = Value(lessonID),
        date = Value(date);
  static Insertable<DatedLesson> custom({
    Expression<int>? id,
    Expression<int>? lessonID,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonID != null) 'lesson_i_d': lessonID,
      if (date != null) 'date': date,
    });
  }

  DatedLessonsCompanion copyWith(
      {Value<int>? id, Value<int>? lessonID, Value<DateTime>? date}) {
    return DatedLessonsCompanion(
      id: id ?? this.id,
      lessonID: lessonID ?? this.lessonID,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lessonID.present) {
      map['lesson_i_d'] = Variable<int>(lessonID.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatedLessonsCompanion(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $RecsTable recs = $RecsTable(this);
  late final $DatedLessonsTable datedLessons = $DatedLessonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, lessons, recs, datedLessons];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
