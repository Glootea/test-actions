// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $SubjectTable extends Subject with TableInfo<$SubjectTable, SubjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'subject';
  @override
  VerificationContext validateIntegrity(Insertable<SubjectData> instance,
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
  SubjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectData(
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
  $SubjectTable createAlias(String alias) {
    return $SubjectTable(attachedDatabase, alias);
  }
}

class SubjectData extends DataClass implements Insertable<SubjectData> {
  final int id;
  final String name;
  final String onlineID;
  final bool autoDelete;
  final bool useWorkCount;
  final DateTime? lastDelete;
  const SubjectData(
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

  SubjectCompanion toCompanion(bool nullToAbsent) {
    return SubjectCompanion(
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

  factory SubjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectData(
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

  SubjectData copyWith(
          {int? id,
          String? name,
          String? onlineID,
          bool? autoDelete,
          bool? useWorkCount,
          Value<DateTime?> lastDelete = const Value.absent()}) =>
      SubjectData(
        id: id ?? this.id,
        name: name ?? this.name,
        onlineID: onlineID ?? this.onlineID,
        autoDelete: autoDelete ?? this.autoDelete,
        useWorkCount: useWorkCount ?? this.useWorkCount,
        lastDelete: lastDelete.present ? lastDelete.value : this.lastDelete,
      );
  @override
  String toString() {
    return (StringBuffer('SubjectData(')
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
      (other is SubjectData &&
          other.id == this.id &&
          other.name == this.name &&
          other.onlineID == this.onlineID &&
          other.autoDelete == this.autoDelete &&
          other.useWorkCount == this.useWorkCount &&
          other.lastDelete == this.lastDelete);
}

class SubjectCompanion extends UpdateCompanion<SubjectData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> onlineID;
  final Value<bool> autoDelete;
  final Value<bool> useWorkCount;
  final Value<DateTime?> lastDelete;
  const SubjectCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.onlineID = const Value.absent(),
    this.autoDelete = const Value.absent(),
    this.useWorkCount = const Value.absent(),
    this.lastDelete = const Value.absent(),
  });
  SubjectCompanion.insert({
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
  static Insertable<SubjectData> custom({
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

  SubjectCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? onlineID,
      Value<bool>? autoDelete,
      Value<bool>? useWorkCount,
      Value<DateTime?>? lastDelete}) {
    return SubjectCompanion(
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
    return (StringBuffer('SubjectCompanion(')
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subjectIDMeta =
      const VerificationMeta('subjectID');
  @override
  late final GeneratedColumn<int> subjectID = GeneratedColumn<int>(
      'subject_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subject (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES subject (id)'));
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
          GeneratedColumn.constraintIsAlways('REFERENCES subject (id)'));
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

class $KeyValueStorageTableTable extends KeyValueStorageTable
    with TableInfo<$KeyValueStorageTableTable, KeyValueStorageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueStorageTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'key_value_storage_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KeyValueStorageTableData> instance,
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
  KeyValueStorageTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueStorageTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $KeyValueStorageTableTable createAlias(String alias) {
    return $KeyValueStorageTableTable(attachedDatabase, alias);
  }
}

class KeyValueStorageTableData extends DataClass
    implements Insertable<KeyValueStorageTableData> {
  final String key;
  final String value;
  const KeyValueStorageTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValueStorageTableCompanion toCompanion(bool nullToAbsent) {
    return KeyValueStorageTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory KeyValueStorageTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueStorageTableData(
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

  KeyValueStorageTableData copyWith({String? key, String? value}) =>
      KeyValueStorageTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('KeyValueStorageTableData(')
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
      (other is KeyValueStorageTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValueStorageTableCompanion
    extends UpdateCompanion<KeyValueStorageTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValueStorageTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueStorageTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<KeyValueStorageTableData> custom({
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

  KeyValueStorageTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return KeyValueStorageTableCompanion(
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
    return (StringBuffer('KeyValueStorageTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  _$LocalDatabaseManager get managers => _$LocalDatabaseManager(this);
  late final $SubjectTable subject = $SubjectTable(this);
  late final $QueueRecsTable queueRecs = $QueueRecsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $WeeklyLessonsTable weeklyLessons = $WeeklyLessonsTable(this);
  late final $DatedLessonsTable datedLessons = $DatedLessonsTable(this);
  late final $KeyValueStorageTableTable keyValueStorageTable =
      $KeyValueStorageTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        subject,
        queueRecs,
        students,
        weeklyLessons,
        datedLessons,
        keyValueStorageTable
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SubjectTableInsertCompanionBuilder = SubjectCompanion Function({
  Value<int> id,
  required String name,
  required String onlineID,
  required bool autoDelete,
  required bool useWorkCount,
  Value<DateTime?> lastDelete,
});
typedef $$SubjectTableUpdateCompanionBuilder = SubjectCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> onlineID,
  Value<bool> autoDelete,
  Value<bool> useWorkCount,
  Value<DateTime?> lastDelete,
});

class $$SubjectTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $SubjectTable,
    SubjectData,
    $$SubjectTableFilterComposer,
    $$SubjectTableOrderingComposer,
    $$SubjectTableProcessedTableManager,
    $$SubjectTableInsertCompanionBuilder,
    $$SubjectTableUpdateCompanionBuilder> {
  $$SubjectTableTableManager(_$LocalDatabase db, $SubjectTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SubjectTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SubjectTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$SubjectTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> onlineID = const Value.absent(),
            Value<bool> autoDelete = const Value.absent(),
            Value<bool> useWorkCount = const Value.absent(),
            Value<DateTime?> lastDelete = const Value.absent(),
          }) =>
              SubjectCompanion(
            id: id,
            name: name,
            onlineID: onlineID,
            autoDelete: autoDelete,
            useWorkCount: useWorkCount,
            lastDelete: lastDelete,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String onlineID,
            required bool autoDelete,
            required bool useWorkCount,
            Value<DateTime?> lastDelete = const Value.absent(),
          }) =>
              SubjectCompanion.insert(
            id: id,
            name: name,
            onlineID: onlineID,
            autoDelete: autoDelete,
            useWorkCount: useWorkCount,
            lastDelete: lastDelete,
          ),
        ));
}

class $$SubjectTableProcessedTableManager extends ProcessedTableManager<
    _$LocalDatabase,
    $SubjectTable,
    SubjectData,
    $$SubjectTableFilterComposer,
    $$SubjectTableOrderingComposer,
    $$SubjectTableProcessedTableManager,
    $$SubjectTableInsertCompanionBuilder,
    $$SubjectTableUpdateCompanionBuilder> {
  $$SubjectTableProcessedTableManager(super.$state);
}

class $$SubjectTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $SubjectTable> {
  $$SubjectTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get onlineID => $state.composableBuilder(
      column: $state.table.onlineID,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get autoDelete => $state.composableBuilder(
      column: $state.table.autoDelete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get useWorkCount => $state.composableBuilder(
      column: $state.table.useWorkCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastDelete => $state.composableBuilder(
      column: $state.table.lastDelete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter queueRecsRefs(
      ComposableFilter Function($$QueueRecsTableFilterComposer f) f) {
    final $$QueueRecsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.queueRecs,
        getReferencedColumn: (t) => t.subjectID,
        builder: (joinBuilder, parentComposers) =>
            $$QueueRecsTableFilterComposer(ComposerState(
                $state.db, $state.db.queueRecs, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter weeklyLessonsRefs(
      ComposableFilter Function($$WeeklyLessonsTableFilterComposer f) f) {
    final $$WeeklyLessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.weeklyLessons,
        getReferencedColumn: (t) => t.lessonID,
        builder: (joinBuilder, parentComposers) =>
            $$WeeklyLessonsTableFilterComposer(ComposerState($state.db,
                $state.db.weeklyLessons, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter datedLessonsRefs(
      ComposableFilter Function($$DatedLessonsTableFilterComposer f) f) {
    final $$DatedLessonsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.datedLessons,
        getReferencedColumn: (t) => t.lessonID,
        builder: (joinBuilder, parentComposers) =>
            $$DatedLessonsTableFilterComposer(ComposerState($state.db,
                $state.db.datedLessons, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SubjectTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $SubjectTable> {
  $$SubjectTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get onlineID => $state.composableBuilder(
      column: $state.table.onlineID,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get autoDelete => $state.composableBuilder(
      column: $state.table.autoDelete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get useWorkCount => $state.composableBuilder(
      column: $state.table.useWorkCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastDelete => $state.composableBuilder(
      column: $state.table.lastDelete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$QueueRecsTableInsertCompanionBuilder = QueueRecsCompanion Function({
  Value<int> id,
  required int studentRowNumber,
  required int subjectID,
  required DateTime time,
  required String status,
  Value<int?> workCount,
});
typedef $$QueueRecsTableUpdateCompanionBuilder = QueueRecsCompanion Function({
  Value<int> id,
  Value<int> studentRowNumber,
  Value<int> subjectID,
  Value<DateTime> time,
  Value<String> status,
  Value<int?> workCount,
});

class $$QueueRecsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $QueueRecsTable,
    QueueRec,
    $$QueueRecsTableFilterComposer,
    $$QueueRecsTableOrderingComposer,
    $$QueueRecsTableProcessedTableManager,
    $$QueueRecsTableInsertCompanionBuilder,
    $$QueueRecsTableUpdateCompanionBuilder> {
  $$QueueRecsTableTableManager(_$LocalDatabase db, $QueueRecsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QueueRecsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QueueRecsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$QueueRecsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> studentRowNumber = const Value.absent(),
            Value<int> subjectID = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> workCount = const Value.absent(),
          }) =>
              QueueRecsCompanion(
            id: id,
            studentRowNumber: studentRowNumber,
            subjectID: subjectID,
            time: time,
            status: status,
            workCount: workCount,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int studentRowNumber,
            required int subjectID,
            required DateTime time,
            required String status,
            Value<int?> workCount = const Value.absent(),
          }) =>
              QueueRecsCompanion.insert(
            id: id,
            studentRowNumber: studentRowNumber,
            subjectID: subjectID,
            time: time,
            status: status,
            workCount: workCount,
          ),
        ));
}

class $$QueueRecsTableProcessedTableManager extends ProcessedTableManager<
    _$LocalDatabase,
    $QueueRecsTable,
    QueueRec,
    $$QueueRecsTableFilterComposer,
    $$QueueRecsTableOrderingComposer,
    $$QueueRecsTableProcessedTableManager,
    $$QueueRecsTableInsertCompanionBuilder,
    $$QueueRecsTableUpdateCompanionBuilder> {
  $$QueueRecsTableProcessedTableManager(super.$state);
}

class $$QueueRecsTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $QueueRecsTable> {
  $$QueueRecsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get studentRowNumber => $state.composableBuilder(
      column: $state.table.studentRowNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get workCount => $state.composableBuilder(
      column: $state.table.workCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SubjectTableFilterComposer get subjectID {
    final $$SubjectTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SubjectTableFilterComposer(
            ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$QueueRecsTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $QueueRecsTable> {
  $$QueueRecsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get studentRowNumber => $state.composableBuilder(
      column: $state.table.studentRowNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get workCount => $state.composableBuilder(
      column: $state.table.workCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SubjectTableOrderingComposer get subjectID {
    final $$SubjectTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SubjectTableOrderingComposer(ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$StudentsTableInsertCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required String name,
  Value<bool?> isAdmin,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<bool?> isAdmin,
});

class $$StudentsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableProcessedTableManager,
    $$StudentsTableInsertCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder> {
  $$StudentsTableTableManager(_$LocalDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$StudentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$StudentsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$StudentsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool?> isAdmin = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            name: name,
            isAdmin: isAdmin,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<bool?> isAdmin = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            name: name,
            isAdmin: isAdmin,
          ),
        ));
}

class $$StudentsTableProcessedTableManager extends ProcessedTableManager<
    _$LocalDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableProcessedTableManager,
    $$StudentsTableInsertCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder> {
  $$StudentsTableProcessedTableManager(super.$state);
}

class $$StudentsTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isAdmin => $state.composableBuilder(
      column: $state.table.isAdmin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$StudentsTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isAdmin => $state.composableBuilder(
      column: $state.table.isAdmin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WeeklyLessonsTableInsertCompanionBuilder = WeeklyLessonsCompanion
    Function({
  Value<int> id,
  required int lessonID,
  required String startTime,
  required String endTime,
  required int weekDay,
});
typedef $$WeeklyLessonsTableUpdateCompanionBuilder = WeeklyLessonsCompanion
    Function({
  Value<int> id,
  Value<int> lessonID,
  Value<String> startTime,
  Value<String> endTime,
  Value<int> weekDay,
});

class $$WeeklyLessonsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $WeeklyLessonsTable,
    WeeklyLesson,
    $$WeeklyLessonsTableFilterComposer,
    $$WeeklyLessonsTableOrderingComposer,
    $$WeeklyLessonsTableProcessedTableManager,
    $$WeeklyLessonsTableInsertCompanionBuilder,
    $$WeeklyLessonsTableUpdateCompanionBuilder> {
  $$WeeklyLessonsTableTableManager(
      _$LocalDatabase db, $WeeklyLessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WeeklyLessonsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WeeklyLessonsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WeeklyLessonsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> lessonID = const Value.absent(),
            Value<String> startTime = const Value.absent(),
            Value<String> endTime = const Value.absent(),
            Value<int> weekDay = const Value.absent(),
          }) =>
              WeeklyLessonsCompanion(
            id: id,
            lessonID: lessonID,
            startTime: startTime,
            endTime: endTime,
            weekDay: weekDay,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int lessonID,
            required String startTime,
            required String endTime,
            required int weekDay,
          }) =>
              WeeklyLessonsCompanion.insert(
            id: id,
            lessonID: lessonID,
            startTime: startTime,
            endTime: endTime,
            weekDay: weekDay,
          ),
        ));
}

class $$WeeklyLessonsTableProcessedTableManager extends ProcessedTableManager<
    _$LocalDatabase,
    $WeeklyLessonsTable,
    WeeklyLesson,
    $$WeeklyLessonsTableFilterComposer,
    $$WeeklyLessonsTableOrderingComposer,
    $$WeeklyLessonsTableProcessedTableManager,
    $$WeeklyLessonsTableInsertCompanionBuilder,
    $$WeeklyLessonsTableUpdateCompanionBuilder> {
  $$WeeklyLessonsTableProcessedTableManager(super.$state);
}

class $$WeeklyLessonsTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $WeeklyLessonsTable> {
  $$WeeklyLessonsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get weekDay => $state.composableBuilder(
      column: $state.table.weekDay,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SubjectTableFilterComposer get lessonID {
    final $$SubjectTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SubjectTableFilterComposer(
            ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$WeeklyLessonsTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $WeeklyLessonsTable> {
  $$WeeklyLessonsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get weekDay => $state.composableBuilder(
      column: $state.table.weekDay,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SubjectTableOrderingComposer get lessonID {
    final $$SubjectTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SubjectTableOrderingComposer(ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$DatedLessonsTableInsertCompanionBuilder = DatedLessonsCompanion
    Function({
  Value<int> id,
  required int lessonID,
  required DateTime date,
  required String startTime,
  required String endTime,
});
typedef $$DatedLessonsTableUpdateCompanionBuilder = DatedLessonsCompanion
    Function({
  Value<int> id,
  Value<int> lessonID,
  Value<DateTime> date,
  Value<String> startTime,
  Value<String> endTime,
});

class $$DatedLessonsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $DatedLessonsTable,
    DatedLesson,
    $$DatedLessonsTableFilterComposer,
    $$DatedLessonsTableOrderingComposer,
    $$DatedLessonsTableProcessedTableManager,
    $$DatedLessonsTableInsertCompanionBuilder,
    $$DatedLessonsTableUpdateCompanionBuilder> {
  $$DatedLessonsTableTableManager(_$LocalDatabase db, $DatedLessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DatedLessonsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DatedLessonsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DatedLessonsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> lessonID = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> startTime = const Value.absent(),
            Value<String> endTime = const Value.absent(),
          }) =>
              DatedLessonsCompanion(
            id: id,
            lessonID: lessonID,
            date: date,
            startTime: startTime,
            endTime: endTime,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int lessonID,
            required DateTime date,
            required String startTime,
            required String endTime,
          }) =>
              DatedLessonsCompanion.insert(
            id: id,
            lessonID: lessonID,
            date: date,
            startTime: startTime,
            endTime: endTime,
          ),
        ));
}

class $$DatedLessonsTableProcessedTableManager extends ProcessedTableManager<
    _$LocalDatabase,
    $DatedLessonsTable,
    DatedLesson,
    $$DatedLessonsTableFilterComposer,
    $$DatedLessonsTableOrderingComposer,
    $$DatedLessonsTableProcessedTableManager,
    $$DatedLessonsTableInsertCompanionBuilder,
    $$DatedLessonsTableUpdateCompanionBuilder> {
  $$DatedLessonsTableProcessedTableManager(super.$state);
}

class $$DatedLessonsTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $DatedLessonsTable> {
  $$DatedLessonsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SubjectTableFilterComposer get lessonID {
    final $$SubjectTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SubjectTableFilterComposer(
            ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$DatedLessonsTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $DatedLessonsTable> {
  $$DatedLessonsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SubjectTableOrderingComposer get lessonID {
    final $$SubjectTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lessonID,
        referencedTable: $state.db.subject,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SubjectTableOrderingComposer(ComposerState(
                $state.db, $state.db.subject, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$KeyValueStorageTableTableInsertCompanionBuilder
    = KeyValueStorageTableCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$KeyValueStorageTableTableUpdateCompanionBuilder
    = KeyValueStorageTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$KeyValueStorageTableTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $KeyValueStorageTableTable,
    KeyValueStorageTableData,
    $$KeyValueStorageTableTableFilterComposer,
    $$KeyValueStorageTableTableOrderingComposer,
    $$KeyValueStorageTableTableProcessedTableManager,
    $$KeyValueStorageTableTableInsertCompanionBuilder,
    $$KeyValueStorageTableTableUpdateCompanionBuilder> {
  $$KeyValueStorageTableTableTableManager(
      _$LocalDatabase db, $KeyValueStorageTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$KeyValueStorageTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$KeyValueStorageTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$KeyValueStorageTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KeyValueStorageTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              KeyValueStorageTableCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
        ));
}

class $$KeyValueStorageTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$LocalDatabase,
        $KeyValueStorageTableTable,
        KeyValueStorageTableData,
        $$KeyValueStorageTableTableFilterComposer,
        $$KeyValueStorageTableTableOrderingComposer,
        $$KeyValueStorageTableTableProcessedTableManager,
        $$KeyValueStorageTableTableInsertCompanionBuilder,
        $$KeyValueStorageTableTableUpdateCompanionBuilder> {
  $$KeyValueStorageTableTableProcessedTableManager(super.$state);
}

class $$KeyValueStorageTableTableFilterComposer
    extends FilterComposer<_$LocalDatabase, $KeyValueStorageTableTable> {
  $$KeyValueStorageTableTableFilterComposer(super.$state);
  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$KeyValueStorageTableTableOrderingComposer
    extends OrderingComposer<_$LocalDatabase, $KeyValueStorageTableTable> {
  $$KeyValueStorageTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$LocalDatabaseManager {
  final _$LocalDatabase _db;
  _$LocalDatabaseManager(this._db);
  $$SubjectTableTableManager get subject =>
      $$SubjectTableTableManager(_db, _db.subject);
  $$QueueRecsTableTableManager get queueRecs =>
      $$QueueRecsTableTableManager(_db, _db.queueRecs);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$WeeklyLessonsTableTableManager get weeklyLessons =>
      $$WeeklyLessonsTableTableManager(_db, _db.weeklyLessons);
  $$DatedLessonsTableTableManager get datedLessons =>
      $$DatedLessonsTableTableManager(_db, _db.datedLessons);
  $$KeyValueStorageTableTableTableManager get keyValueStorageTable =>
      $$KeyValueStorageTableTableTableManager(_db, _db.keyValueStorageTable);
}
