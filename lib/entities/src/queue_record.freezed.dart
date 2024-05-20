// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QueueRecord {
  Lesson get lesson => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  int get studentID => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  QueueRecordStatus get status => throw _privateConstructorUsedError;
  int? get workCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QueueRecordCopyWith<QueueRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueRecordCopyWith<$Res> {
  factory $QueueRecordCopyWith(
          QueueRecord value, $Res Function(QueueRecord) then) =
      _$QueueRecordCopyWithImpl<$Res, QueueRecord>;
  @useResult
  $Res call(
      {Lesson lesson,
      String studentName,
      int studentID,
      DateTime time,
      QueueRecordStatus status,
      int? workCount});

  $LessonCopyWith<$Res> get lesson;
}

/// @nodoc
class _$QueueRecordCopyWithImpl<$Res, $Val extends QueueRecord>
    implements $QueueRecordCopyWith<$Res> {
  _$QueueRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? studentName = null,
    Object? studentID = null,
    Object? time = null,
    Object? status = null,
    Object? workCount = freezed,
  }) {
    return _then(_value.copyWith(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentID: null == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus,
      workCount: freezed == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LessonCopyWith<$Res> get lesson {
    return $LessonCopyWith<$Res>(_value.lesson, (value) {
      return _then(_value.copyWith(lesson: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueRecordImplCopyWith<$Res>
    implements $QueueRecordCopyWith<$Res> {
  factory _$$QueueRecordImplCopyWith(
          _$QueueRecordImpl value, $Res Function(_$QueueRecordImpl) then) =
      __$$QueueRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Lesson lesson,
      String studentName,
      int studentID,
      DateTime time,
      QueueRecordStatus status,
      int? workCount});

  @override
  $LessonCopyWith<$Res> get lesson;
}

/// @nodoc
class __$$QueueRecordImplCopyWithImpl<$Res>
    extends _$QueueRecordCopyWithImpl<$Res, _$QueueRecordImpl>
    implements _$$QueueRecordImplCopyWith<$Res> {
  __$$QueueRecordImplCopyWithImpl(
      _$QueueRecordImpl _value, $Res Function(_$QueueRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? studentName = null,
    Object? studentID = null,
    Object? time = null,
    Object? status = null,
    Object? workCount = freezed,
  }) {
    return _then(_$QueueRecordImpl(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentID: null == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus,
      workCount: freezed == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$QueueRecordImpl extends _QueueRecord {
  const _$QueueRecordImpl(
      {required this.lesson,
      required this.studentName,
      required this.studentID,
      required this.time,
      required this.status,
      this.workCount})
      : super._();

  @override
  final Lesson lesson;
  @override
  final String studentName;
  @override
  final int studentID;
  @override
  final DateTime time;
  @override
  final QueueRecordStatus status;
  @override
  final int? workCount;

  @override
  String toString() {
    return 'QueueRecord(lesson: $lesson, studentName: $studentName, studentID: $studentID, time: $time, status: $status, workCount: $workCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueRecordImpl &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentID, studentID) ||
                other.studentID == studentID) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workCount, workCount) ||
                other.workCount == workCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, lesson, studentName, studentID, time, status, workCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueRecordImplCopyWith<_$QueueRecordImpl> get copyWith =>
      __$$QueueRecordImplCopyWithImpl<_$QueueRecordImpl>(this, _$identity);
}

abstract class _QueueRecord extends QueueRecord {
  const factory _QueueRecord(
      {required final Lesson lesson,
      required final String studentName,
      required final int studentID,
      required final DateTime time,
      required final QueueRecordStatus status,
      final int? workCount}) = _$QueueRecordImpl;
  const _QueueRecord._() : super._();

  @override
  Lesson get lesson;
  @override
  String get studentName;
  @override
  int get studentID;
  @override
  DateTime get time;
  @override
  QueueRecordStatus get status;
  @override
  int? get workCount;
  @override
  @JsonKey(ignore: true)
  _$$QueueRecordImplCopyWith<_$QueueRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
