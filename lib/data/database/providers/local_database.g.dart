// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

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
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isAdminMeta =
      const VerificationMeta('isAdmin');
  @override
  late final GeneratedColumn<bool> isAdmin = GeneratedColumn<bool>(
      'is_admin', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_admin" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, name, isAdmin];
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
    if (data.containsKey('is_admin')) {
      context.handle(_isAdminMeta,
          isAdmin.isAcceptableOrUnknown(data['is_admin']!, _isAdminMeta));
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
      isAdmin: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_admin']),
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
  final bool? isAdmin;
  const Student({required this.id, required this.name, this.isAdmin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || isAdmin != null) {
      map['is_admin'] = Variable<bool>(isAdmin);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      isAdmin: isAdmin == null && nullToAbsent
          ? const Value.absent()
          : Value(isAdmin),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isAdmin: serializer.fromJson<bool?>(json['isAdmin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isAdmin': serializer.toJson<bool?>(isAdmin),
    };
  }

  Student copyWith(
          {int? id,
          String? name,
          Value<bool?> isAdmin = const Value.absent()}) =>
      Student(
        id: id ?? this.id,
        name: name ?? this.name,
        isAdmin: isAdmin.present ? isAdmin.value : this.isAdmin,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isAdmin: $isAdmin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isAdmin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.isAdmin == this.isAdmin);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool?> isAdmin;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isAdmin = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isAdmin = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isAdmin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isAdmin != null) 'is_admin': isAdmin,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<bool?>? isAdmin}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
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
    if (isAdmin.present) {
      map['is_admin'] = Variable<bool>(isAdmin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isAdmin: $isAdmin')
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
  static const VerificationMeta _onlineIDMeta =
      const VerificationMeta('onlineID');
  @override
  late final GeneratedColumn<String> onlineID = GeneratedColumn<String>(
      'online_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, onlineID];
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
    if (data.containsKey('online_i_d')) {
      context.handle(_onlineIDMeta,
          onlineID.isAcceptableOrUnknown(data['online_i_d']!, _onlineIDMeta));
    } else if (isInserting) {
      context.missing(_onlineIDMeta);
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
      onlineID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}online_i_d'])!,
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
  final String onlineID;
  const Lesson({required this.id, required this.name, required this.onlineID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['online_i_d'] = Variable<String>(onlineID);
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      name: Value(name),
      onlineID: Value(onlineID),
    );
  }

  factory Lesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      onlineID: serializer.fromJson<String>(json['onlineID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'onlineID': serializer.toJson<String>(onlineID),
    };
  }

  Lesson copyWith({int? id, String? name, String? onlineID}) => Lesson(
        id: id ?? this.id,
        name: name ?? this.name,
        onlineID: onlineID ?? this.onlineID,
      );
  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('onlineID: $onlineID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, onlineID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.name == this.name &&
          other.onlineID == this.onlineID);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> onlineID;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.onlineID = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String onlineID,
  })  : name = Value(name),
        onlineID = Value(onlineID);
  static Insertable<Lesson> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? onlineID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (onlineID != null) 'online_i_d': onlineID,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? onlineID}) {
    return LessonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      onlineID: onlineID ?? this.onlineID,
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
    if (onlineID.present) {
      map['online_i_d'] = Variable<String>(onlineID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('onlineID: $onlineID')
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
  late final GeneratedColumn<int> uploaded = GeneratedColumn<int>(
      'uploaded', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_uploadedMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}uploaded'])!,
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

  /// 1 - uploaded; 0 - not uploaded, but should be; -1 - should be deleted
  final int uploaded;
  const Rec(
      {required this.id,
      required this.studentID,
      required this.lessonID,
      required this.time,
      required this.uploaded});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_i_d'] = Variable<int>(studentID);
    map['lesson_i_d'] = Variable<int>(lessonID);
    map['time'] = Variable<DateTime>(time);
    map['uploaded'] = Variable<int>(uploaded);
    return map;
  }

  RecsCompanion toCompanion(bool nullToAbsent) {
    return RecsCompanion(
      id: Value(id),
      studentID: Value(studentID),
      lessonID: Value(lessonID),
      time: Value(time),
      uploaded: Value(uploaded),
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
      uploaded: serializer.fromJson<int>(json['uploaded']),
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
      'uploaded': serializer.toJson<int>(uploaded),
    };
  }

  Rec copyWith(
          {int? id,
          int? studentID,
          int? lessonID,
          DateTime? time,
          int? uploaded}) =>
      Rec(
        id: id ?? this.id,
        studentID: studentID ?? this.studentID,
        lessonID: lessonID ?? this.lessonID,
        time: time ?? this.time,
        uploaded: uploaded ?? this.uploaded,
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
  final Value<int> uploaded;
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
    required int uploaded,
  })  : studentID = Value(studentID),
        lessonID = Value(lessonID),
        time = Value(time),
        uploaded = Value(uploaded);
  static Insertable<Rec> custom({
    Expression<int>? id,
    Expression<int>? studentID,
    Expression<int>? lessonID,
    Expression<DateTime>? time,
    Expression<int>? uploaded,
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
      Value<int>? uploaded}) {
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
      map['uploaded'] = Variable<int>(uploaded.value);
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

class $WeeklyLessonsTable extends WeeklyLessons
    with TableInfo<$WeeklyLessonsTable, WeeklyLesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyLessonsTable(this.attachedDatabase, [this._alias]);
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
      [id, lessonID, startTime, endTime, weekDay];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_lessons';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklyLesson> instance,
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
  WeeklyLesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyLesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lessonID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_i_d'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time'])!,
      weekDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_day'])!,
    );
  }

  @override
  $WeeklyLessonsTable createAlias(String alias) {
    return $WeeklyLessonsTable(attachedDatabase, alias);
  }
}

class WeeklyLesson extends DataClass implements Insertable<WeeklyLesson> {
  final int id;
  final int lessonID;
  final String startTime;
  final String endTime;
  final int weekDay;
  const WeeklyLesson(
      {required this.id,
      required this.lessonID,
      required this.startTime,
      required this.endTime,
      required this.weekDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_i_d'] = Variable<int>(lessonID);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['week_day'] = Variable<int>(weekDay);
    return map;
  }

  WeeklyLessonsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyLessonsCompanion(
      id: Value(id),
      lessonID: Value(lessonID),
      startTime: Value(startTime),
      endTime: Value(endTime),
      weekDay: Value(weekDay),
    );
  }

  factory WeeklyLesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyLesson(
      id: serializer.fromJson<int>(json['id']),
      lessonID: serializer.fromJson<int>(json['lessonID']),
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
      'lessonID': serializer.toJson<int>(lessonID),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'weekDay': serializer.toJson<int>(weekDay),
    };
  }

  WeeklyLesson copyWith(
          {int? id,
          int? lessonID,
          String? startTime,
          String? endTime,
          int? weekDay}) =>
      WeeklyLesson(
        id: id ?? this.id,
        lessonID: lessonID ?? this.lessonID,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        weekDay: weekDay ?? this.weekDay,
      );
  @override
  String toString() {
    return (StringBuffer('WeeklyLesson(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weekDay: $weekDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonID, startTime, endTime, weekDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyLesson &&
          other.id == this.id &&
          other.lessonID == this.lessonID &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.weekDay == this.weekDay);
}

class WeeklyLessonsCompanion extends UpdateCompanion<WeeklyLesson> {
  final Value<int> id;
  final Value<int> lessonID;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<int> weekDay;
  const WeeklyLessonsCompanion({
    this.id = const Value.absent(),
    this.lessonID = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.weekDay = const Value.absent(),
  });
  WeeklyLessonsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonID,
    required String startTime,
    required String endTime,
    required int weekDay,
  })  : lessonID = Value(lessonID),
        startTime = Value(startTime),
        endTime = Value(endTime),
        weekDay = Value(weekDay);
  static Insertable<WeeklyLesson> custom({
    Expression<int>? id,
    Expression<int>? lessonID,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<int>? weekDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonID != null) 'lesson_i_d': lessonID,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (weekDay != null) 'week_day': weekDay,
    });
  }

  WeeklyLessonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? lessonID,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<int>? weekDay}) {
    return WeeklyLessonsCompanion(
      id: id ?? this.id,
      lessonID: lessonID ?? this.lessonID,
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
    if (lessonID.present) {
      map['lesson_i_d'] = Variable<int>(lessonID.value);
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
    return (StringBuffer('WeeklyLessonsCompanion(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('weekDay: $weekDay')
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, lessonID, date, startTime, endTime];
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
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time'])!,
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
  final String startTime;
  final String endTime;
  const DatedLesson(
      {required this.id,
      required this.lessonID,
      required this.date,
      required this.startTime,
      required this.endTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lesson_i_d'] = Variable<int>(lessonID);
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    return map;
  }

  DatedLessonsCompanion toCompanion(bool nullToAbsent) {
    return DatedLessonsCompanion(
      id: Value(id),
      lessonID: Value(lessonID),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
    );
  }

  factory DatedLesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatedLesson(
      id: serializer.fromJson<int>(json['id']),
      lessonID: serializer.fromJson<int>(json['lessonID']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lessonID': serializer.toJson<int>(lessonID),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
    };
  }

  DatedLesson copyWith(
          {int? id,
          int? lessonID,
          DateTime? date,
          String? startTime,
          String? endTime}) =>
      DatedLesson(
        id: id ?? this.id,
        lessonID: lessonID ?? this.lessonID,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('DatedLesson(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lessonID, date, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatedLesson &&
          other.id == this.id &&
          other.lessonID == this.lessonID &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class DatedLessonsCompanion extends UpdateCompanion<DatedLesson> {
  final Value<int> id;
  final Value<int> lessonID;
  final Value<DateTime> date;
  final Value<String> startTime;
  final Value<String> endTime;
  const DatedLessonsCompanion({
    this.id = const Value.absent(),
    this.lessonID = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  DatedLessonsCompanion.insert({
    this.id = const Value.absent(),
    required int lessonID,
    required DateTime date,
    required String startTime,
    required String endTime,
  })  : lessonID = Value(lessonID),
        date = Value(date),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<DatedLesson> custom({
    Expression<int>? id,
    Expression<int>? lessonID,
    Expression<DateTime>? date,
    Expression<String>? startTime,
    Expression<String>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonID != null) 'lesson_i_d': lessonID,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  DatedLessonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? lessonID,
      Value<DateTime>? date,
      Value<String>? startTime,
      Value<String>? endTime}) {
    return DatedLessonsCompanion(
      id: id ?? this.id,
      lessonID: lessonID ?? this.lessonID,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
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
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatedLessonsCompanion(')
          ..write('id: $id, ')
          ..write('lessonID: $lessonID, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $UserInfoTable extends UserInfo
    with TableInfo<$UserInfoTable, UserInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_info';
  @override
  VerificationContext validateIntegrity(Insertable<UserInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserInfoData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $UserInfoTable createAlias(String alias) {
    return $UserInfoTable(attachedDatabase, alias);
  }
}

class UserInfoData extends DataClass implements Insertable<UserInfoData> {
  final String key;
  final String value;
  const UserInfoData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  UserInfoCompanion toCompanion(bool nullToAbsent) {
    return UserInfoCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory UserInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserInfoData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  UserInfoData copyWith({String? key, String? value}) => UserInfoData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('UserInfoData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfoData &&
          other.key == this.key &&
          other.value == this.value);
}

class UserInfoCompanion extends UpdateCompanion<UserInfoData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const UserInfoCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserInfoCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<UserInfoData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserInfoCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return UserInfoCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserInfoCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $RecsTable recs = $RecsTable(this);
  late final $WeeklyLessonsTable weeklyLessons = $WeeklyLessonsTable(this);
  late final $DatedLessonsTable datedLessons = $DatedLessonsTable(this);
  late final $UserInfoTable userInfo = $UserInfoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, lessons, recs, weeklyLessons, datedLessons, userInfo];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
