// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_local_database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowNumberMeta =
      const VerificationMeta('rowNumber');
  @override
  late final GeneratedColumn<int> rowNumber = GeneratedColumn<int>(
      'row_number', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [rowNumber, name, isAdmin];
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
    if (data.containsKey('row_number')) {
      context.handle(_rowNumberMeta,
          rowNumber.isAcceptableOrUnknown(data['row_number']!, _rowNumberMeta));
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
  Set<GeneratedColumn> get $primaryKey => {rowNumber};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      rowNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}row_number'])!,
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
  final int rowNumber;
  final String name;
  final bool? isAdmin;
  const Student({required this.rowNumber, required this.name, this.isAdmin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_number'] = Variable<int>(rowNumber);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || isAdmin != null) {
      map['is_admin'] = Variable<bool>(isAdmin);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      rowNumber: Value(rowNumber),
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
      rowNumber: serializer.fromJson<int>(json['rowNumber']),
      name: serializer.fromJson<String>(json['name']),
      isAdmin: serializer.fromJson<bool?>(json['isAdmin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowNumber': serializer.toJson<int>(rowNumber),
      'name': serializer.toJson<String>(name),
      'isAdmin': serializer.toJson<bool?>(isAdmin),
    };
  }

  Student copyWith(
          {int? rowNumber,
          String? name,
          Value<bool?> isAdmin = const Value.absent()}) =>
      Student(
        rowNumber: rowNumber ?? this.rowNumber,
        name: name ?? this.name,
        isAdmin: isAdmin.present ? isAdmin.value : this.isAdmin,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('rowNumber: $rowNumber, ')
          ..write('name: $name, ')
          ..write('isAdmin: $isAdmin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(rowNumber, name, isAdmin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.rowNumber == this.rowNumber &&
          other.name == this.name &&
          other.isAdmin == this.isAdmin);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> rowNumber;
  final Value<String> name;
  final Value<bool?> isAdmin;
  const StudentsCompanion({
    this.rowNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.isAdmin = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.rowNumber = const Value.absent(),
    required String name,
    this.isAdmin = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Student> custom({
    Expression<int>? rowNumber,
    Expression<String>? name,
    Expression<bool>? isAdmin,
  }) {
    return RawValuesInsertable({
      if (rowNumber != null) 'row_number': rowNumber,
      if (name != null) 'name': name,
      if (isAdmin != null) 'is_admin': isAdmin,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? rowNumber, Value<String>? name, Value<bool?>? isAdmin}) {
    return StudentsCompanion(
      rowNumber: rowNumber ?? this.rowNumber,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowNumber.present) {
      map['row_number'] = Variable<int>(rowNumber.value);
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
          ..write('rowNumber: $rowNumber, ')
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
  static const VerificationMeta _autoDeleteMeta =
      const VerificationMeta('autoDelete');
  @override
  late final GeneratedColumn<bool> autoDelete = GeneratedColumn<bool>(
      'auto_delete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_delete" IN (0, 1))'));
  static const VerificationMeta _useWorkCountMeta =
      const VerificationMeta('useWorkCount');
  @override
  late final GeneratedColumn<bool> useWorkCount = GeneratedColumn<bool>(
      'use_work_count', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_work_count" IN (0, 1))'));
  static const VerificationMeta _lastDeleteMeta =
      const VerificationMeta('lastDelete');
  @override
  late final GeneratedColumn<DateTime> lastDelete = GeneratedColumn<DateTime>(
      'last_delete', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, onlineID, autoDelete, useWorkCount, lastDelete];
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
    if (data.containsKey('auto_delete')) {
      context.handle(
          _autoDeleteMeta,
          autoDelete.isAcceptableOrUnknown(
              data['auto_delete']!, _autoDeleteMeta));
    } else if (isInserting) {
      context.missing(_autoDeleteMeta);
    }
    if (data.containsKey('use_work_count')) {
      context.handle(
          _useWorkCountMeta,
          useWorkCount.isAcceptableOrUnknown(
              data['use_work_count']!, _useWorkCountMeta));
    } else if (isInserting) {
      context.missing(_useWorkCountMeta);
    }
    if (data.containsKey('last_delete')) {
      context.handle(
          _lastDeleteMeta,
          lastDelete.isAcceptableOrUnknown(
              data['last_delete']!, _lastDeleteMeta));
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
      autoDelete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}auto_delete'])!,
      useWorkCount: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_work_count'])!,
      lastDelete: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_delete']),
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
  final bool autoDelete;
  final bool useWorkCount;
  final DateTime? lastDelete;
  const Lesson(
      {required this.id,
      required this.name,
      required this.onlineID,
      required this.autoDelete,
      required this.useWorkCount,
      this.lastDelete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['online_i_d'] = Variable<String>(onlineID);
    map['auto_delete'] = Variable<bool>(autoDelete);
    map['use_work_count'] = Variable<bool>(useWorkCount);
    if (!nullToAbsent || lastDelete != null) {
      map['last_delete'] = Variable<DateTime>(lastDelete);
    }
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      name: Value(name),
      onlineID: Value(onlineID),
      autoDelete: Value(autoDelete),
      useWorkCount: Value(useWorkCount),
      lastDelete: lastDelete == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDelete),
    );
  }

  factory Lesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      onlineID: serializer.fromJson<String>(json['onlineID']),
      autoDelete: serializer.fromJson<bool>(json['autoDelete']),
      useWorkCount: serializer.fromJson<bool>(json['useWorkCount']),
      lastDelete: serializer.fromJson<DateTime?>(json['lastDelete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'onlineID': serializer.toJson<String>(onlineID),
      'autoDelete': serializer.toJson<bool>(autoDelete),
      'useWorkCount': serializer.toJson<bool>(useWorkCount),
      'lastDelete': serializer.toJson<DateTime?>(lastDelete),
    };
  }

  Lesson copyWith(
          {int? id,
          String? name,
          String? onlineID,
          bool? autoDelete,
          bool? useWorkCount,
          Value<DateTime?> lastDelete = const Value.absent()}) =>
      Lesson(
        id: id ?? this.id,
        name: name ?? this.name,
        onlineID: onlineID ?? this.onlineID,
        autoDelete: autoDelete ?? this.autoDelete,
        useWorkCount: useWorkCount ?? this.useWorkCount,
        lastDelete: lastDelete.present ? lastDelete.value : this.lastDelete,
      );
  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('onlineID: $onlineID, ')
          ..write('autoDelete: $autoDelete, ')
          ..write('useWorkCount: $useWorkCount, ')
          ..write('lastDelete: $lastDelete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, onlineID, autoDelete, useWorkCount, lastDelete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.name == this.name &&
          other.onlineID == this.onlineID &&
          other.autoDelete == this.autoDelete &&
          other.useWorkCount == this.useWorkCount &&
          other.lastDelete == this.lastDelete);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> onlineID;
  final Value<bool> autoDelete;
  final Value<bool> useWorkCount;
  final Value<DateTime?> lastDelete;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.onlineID = const Value.absent(),
    this.autoDelete = const Value.absent(),
    this.useWorkCount = const Value.absent(),
    this.lastDelete = const Value.absent(),
  });
  LessonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String onlineID,
    required bool autoDelete,
    required bool useWorkCount,
    this.lastDelete = const Value.absent(),
  })  : name = Value(name),
        onlineID = Value(onlineID),
        autoDelete = Value(autoDelete),
        useWorkCount = Value(useWorkCount);
  static Insertable<Lesson> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? onlineID,
    Expression<bool>? autoDelete,
    Expression<bool>? useWorkCount,
    Expression<DateTime>? lastDelete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (onlineID != null) 'online_i_d': onlineID,
      if (autoDelete != null) 'auto_delete': autoDelete,
      if (useWorkCount != null) 'use_work_count': useWorkCount,
      if (lastDelete != null) 'last_delete': lastDelete,
    });
  }

  LessonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? onlineID,
      Value<bool>? autoDelete,
      Value<bool>? useWorkCount,
      Value<DateTime?>? lastDelete}) {
    return LessonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      onlineID: onlineID ?? this.onlineID,
      autoDelete: autoDelete ?? this.autoDelete,
      useWorkCount: useWorkCount ?? this.useWorkCount,
      lastDelete: lastDelete ?? this.lastDelete,
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
    if (autoDelete.present) {
      map['auto_delete'] = Variable<bool>(autoDelete.value);
    }
    if (useWorkCount.present) {
      map['use_work_count'] = Variable<bool>(useWorkCount.value);
    }
    if (lastDelete.present) {
      map['last_delete'] = Variable<DateTime>(lastDelete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('onlineID: $onlineID, ')
          ..write('autoDelete: $autoDelete, ')
          ..write('useWorkCount: $useWorkCount, ')
          ..write('lastDelete: $lastDelete')
          ..write(')'))
        .toString();
  }
}

class $QueueRecsTable extends QueueRecs
    with TableInfo<$QueueRecsTable, QueueRec> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueueRecsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentRowNumberMeta =
      const VerificationMeta('studentRowNumber');
  @override
  late final GeneratedColumn<int> studentRowNumber = GeneratedColumn<int>(
      'student_row_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES students (row_number)'));
  static const VerificationMeta _subjectIDMeta =
      const VerificationMeta('subjectID');
  @override
  late final GeneratedColumn<int> subjectID = GeneratedColumn<int>(
      'subject_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lessons (id)'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workCountMeta =
      const VerificationMeta('workCount');
  @override
  late final GeneratedColumn<int> workCount = GeneratedColumn<int>(
      'work_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, studentRowNumber, subjectID, time, status, workCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queue_recs';
  @override
  VerificationContext validateIntegrity(Insertable<QueueRec> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_row_number')) {
      context.handle(
          _studentRowNumberMeta,
          studentRowNumber.isAcceptableOrUnknown(
              data['student_row_number']!, _studentRowNumberMeta));
    } else if (isInserting) {
      context.missing(_studentRowNumberMeta);
    }
    if (data.containsKey('subject_i_d')) {
      context.handle(
          _subjectIDMeta,
          subjectID.isAcceptableOrUnknown(
              data['subject_i_d']!, _subjectIDMeta));
    } else if (isInserting) {
      context.missing(_subjectIDMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('work_count')) {
      context.handle(_workCountMeta,
          workCount.isAcceptableOrUnknown(data['work_count']!, _workCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QueueRec map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueueRec(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentRowNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}student_row_number'])!,
      subjectID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subject_i_d'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      workCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_count']),
    );
  }

  @override
  $QueueRecsTable createAlias(String alias) {
    return $QueueRecsTable(attachedDatabase, alias);
  }
}

class QueueRec extends DataClass implements Insertable<QueueRec> {
  final int id;
  final int studentRowNumber;
  final int subjectID;
  final DateTime time;
  final String status;
  final int? workCount;
  const QueueRec(
      {required this.id,
      required this.studentRowNumber,
      required this.subjectID,
      required this.time,
      required this.status,
      this.workCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_row_number'] = Variable<int>(studentRowNumber);
    map['subject_i_d'] = Variable<int>(subjectID);
    map['time'] = Variable<DateTime>(time);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || workCount != null) {
      map['work_count'] = Variable<int>(workCount);
    }
    return map;
  }

  QueueRecsCompanion toCompanion(bool nullToAbsent) {
    return QueueRecsCompanion(
      id: Value(id),
      studentRowNumber: Value(studentRowNumber),
      subjectID: Value(subjectID),
      time: Value(time),
      status: Value(status),
      workCount: workCount == null && nullToAbsent
          ? const Value.absent()
          : Value(workCount),
    );
  }

  factory QueueRec.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueueRec(
      id: serializer.fromJson<int>(json['id']),
      studentRowNumber: serializer.fromJson<int>(json['studentRowNumber']),
      subjectID: serializer.fromJson<int>(json['subjectID']),
      time: serializer.fromJson<DateTime>(json['time']),
      status: serializer.fromJson<String>(json['status']),
      workCount: serializer.fromJson<int?>(json['workCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentRowNumber': serializer.toJson<int>(studentRowNumber),
      'subjectID': serializer.toJson<int>(subjectID),
      'time': serializer.toJson<DateTime>(time),
      'status': serializer.toJson<String>(status),
      'workCount': serializer.toJson<int?>(workCount),
    };
  }

  QueueRec copyWith(
          {int? id,
          int? studentRowNumber,
          int? subjectID,
          DateTime? time,
          String? status,
          Value<int?> workCount = const Value.absent()}) =>
      QueueRec(
        id: id ?? this.id,
        studentRowNumber: studentRowNumber ?? this.studentRowNumber,
        subjectID: subjectID ?? this.subjectID,
        time: time ?? this.time,
        status: status ?? this.status,
        workCount: workCount.present ? workCount.value : this.workCount,
      );
  @override
  String toString() {
    return (StringBuffer('QueueRec(')
          ..write('id: $id, ')
          ..write('studentRowNumber: $studentRowNumber, ')
          ..write('subjectID: $subjectID, ')
          ..write('time: $time, ')
          ..write('status: $status, ')
          ..write('workCount: $workCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, studentRowNumber, subjectID, time, status, workCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueueRec &&
          other.id == this.id &&
          other.studentRowNumber == this.studentRowNumber &&
          other.subjectID == this.subjectID &&
          other.time == this.time &&
          other.status == this.status &&
          other.workCount == this.workCount);
}

class QueueRecsCompanion extends UpdateCompanion<QueueRec> {
  final Value<int> id;
  final Value<int> studentRowNumber;
  final Value<int> subjectID;
  final Value<DateTime> time;
  final Value<String> status;
  final Value<int?> workCount;
  const QueueRecsCompanion({
    this.id = const Value.absent(),
    this.studentRowNumber = const Value.absent(),
    this.subjectID = const Value.absent(),
    this.time = const Value.absent(),
    this.status = const Value.absent(),
    this.workCount = const Value.absent(),
  });
  QueueRecsCompanion.insert({
    this.id = const Value.absent(),
    required int studentRowNumber,
    required int subjectID,
    required DateTime time,
    required String status,
    this.workCount = const Value.absent(),
  })  : studentRowNumber = Value(studentRowNumber),
        subjectID = Value(subjectID),
        time = Value(time),
        status = Value(status);
  static Insertable<QueueRec> custom({
    Expression<int>? id,
    Expression<int>? studentRowNumber,
    Expression<int>? subjectID,
    Expression<DateTime>? time,
    Expression<String>? status,
    Expression<int>? workCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentRowNumber != null) 'student_row_number': studentRowNumber,
      if (subjectID != null) 'subject_i_d': subjectID,
      if (time != null) 'time': time,
      if (status != null) 'status': status,
      if (workCount != null) 'work_count': workCount,
    });
  }

  QueueRecsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentRowNumber,
      Value<int>? subjectID,
      Value<DateTime>? time,
      Value<String>? status,
      Value<int?>? workCount}) {
    return QueueRecsCompanion(
      id: id ?? this.id,
      studentRowNumber: studentRowNumber ?? this.studentRowNumber,
      subjectID: subjectID ?? this.subjectID,
      time: time ?? this.time,
      status: status ?? this.status,
      workCount: workCount ?? this.workCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentRowNumber.present) {
      map['student_row_number'] = Variable<int>(studentRowNumber.value);
    }
    if (subjectID.present) {
      map['subject_i_d'] = Variable<int>(subjectID.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (workCount.present) {
      map['work_count'] = Variable<int>(workCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueRecsCompanion(')
          ..write('id: $id, ')
          ..write('studentRowNumber: $studentRowNumber, ')
          ..write('subjectID: $subjectID, ')
          ..write('time: $time, ')
          ..write('status: $status, ')
          ..write('workCount: $workCount')
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

class $KeyValueStorageTable extends KeyValueStorage
    with TableInfo<$KeyValueStorageTable, KeyValueStorageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueStorageTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'key_value_storage';
  @override
  VerificationContext validateIntegrity(
      Insertable<KeyValueStorageData> instance,
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
  KeyValueStorageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueStorageData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $KeyValueStorageTable createAlias(String alias) {
    return $KeyValueStorageTable(attachedDatabase, alias);
  }
}

class KeyValueStorageData extends DataClass
    implements Insertable<KeyValueStorageData> {
  final String key;
  final String value;
  const KeyValueStorageData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValueStorageCompanion toCompanion(bool nullToAbsent) {
    return KeyValueStorageCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory KeyValueStorageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueStorageData(
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

  KeyValueStorageData copyWith({String? key, String? value}) =>
      KeyValueStorageData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('KeyValueStorageData(')
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
      (other is KeyValueStorageData &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValueStorageCompanion extends UpdateCompanion<KeyValueStorageData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValueStorageCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueStorageCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<KeyValueStorageData> custom({
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

  KeyValueStorageCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return KeyValueStorageCompanion(
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
    return (StringBuffer('KeyValueStorageCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$NewLocalDatabase extends GeneratedDatabase {
  _$NewLocalDatabase(QueryExecutor e) : super(e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $QueueRecsTable queueRecs = $QueueRecsTable(this);
  late final $WeeklyLessonsTable weeklyLessons = $WeeklyLessonsTable(this);
  late final $DatedLessonsTable datedLessons = $DatedLessonsTable(this);
  late final $KeyValueStorageTable keyValueStorage =
      $KeyValueStorageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        students,
        lessons,
        queueRecs,
        weeklyLessons,
        datedLessons,
        keyValueStorage
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
