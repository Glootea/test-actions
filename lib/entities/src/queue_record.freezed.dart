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
  int get localSubjectID => throw _privateConstructorUsedError;
  String get onlineTableID => throw _privateConstructorUsedError;
  int get studentRowNumber => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  int? get workCount => throw _privateConstructorUsedError;
  QueueRecordStatus get status => throw _privateConstructorUsedError;

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
      {int localSubjectID,
      String onlineTableID,
      int studentRowNumber,
      DateTime time,
      int? workCount,
      QueueRecordStatus status});
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
    Object? localSubjectID = null,
    Object? onlineTableID = null,
    Object? studentRowNumber = null,
    Object? time = null,
    Object? workCount = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      localSubjectID: null == localSubjectID
          ? _value.localSubjectID
          : localSubjectID // ignore: cast_nullable_to_non_nullable
              as int,
      onlineTableID: null == onlineTableID
          ? _value.onlineTableID
          : onlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      studentRowNumber: null == studentRowNumber
          ? _value.studentRowNumber
          : studentRowNumber // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workCount: freezed == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus,
    ) as $Val);
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
      {int localSubjectID,
      String onlineTableID,
      int studentRowNumber,
      DateTime time,
      int? workCount,
      QueueRecordStatus status});
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
    Object? localSubjectID = null,
    Object? onlineTableID = null,
    Object? studentRowNumber = null,
    Object? time = null,
    Object? workCount = freezed,
    Object? status = null,
  }) {
    return _then(_$QueueRecordImpl(
      localSubjectID: null == localSubjectID
          ? _value.localSubjectID
          : localSubjectID // ignore: cast_nullable_to_non_nullable
              as int,
      onlineTableID: null == onlineTableID
          ? _value.onlineTableID
          : onlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      studentRowNumber: null == studentRowNumber
          ? _value.studentRowNumber
          : studentRowNumber // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workCount: freezed == workCount
          ? _value.workCount
          : workCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus,
    ));
  }
}

/// @nodoc

class _$QueueRecordImpl extends _QueueRecord {
  const _$QueueRecordImpl(
      {required this.localSubjectID,
      required this.onlineTableID,
      required this.studentRowNumber,
      required this.time,
      this.workCount,
      required this.status})
      : super._();

  @override
  final int localSubjectID;
  @override
  final String onlineTableID;
  @override
  final int studentRowNumber;
  @override
  final DateTime time;
  @override
  final int? workCount;
  @override
  final QueueRecordStatus status;

  @override
  String toString() {
    return 'QueueRecord(localSubjectID: $localSubjectID, onlineTableID: $onlineTableID, studentRowNumber: $studentRowNumber, time: $time, workCount: $workCount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueRecordImpl &&
            (identical(other.localSubjectID, localSubjectID) ||
                other.localSubjectID == localSubjectID) &&
            (identical(other.onlineTableID, onlineTableID) ||
                other.onlineTableID == onlineTableID) &&
            (identical(other.studentRowNumber, studentRowNumber) ||
                other.studentRowNumber == studentRowNumber) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.workCount, workCount) ||
                other.workCount == workCount) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localSubjectID, onlineTableID,
      studentRowNumber, time, workCount, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueRecordImplCopyWith<_$QueueRecordImpl> get copyWith =>
      __$$QueueRecordImplCopyWithImpl<_$QueueRecordImpl>(this, _$identity);
}

abstract class _QueueRecord extends QueueRecord {
  const factory _QueueRecord(
      {required final int localSubjectID,
      required final String onlineTableID,
      required final int studentRowNumber,
      required final DateTime time,
      final int? workCount,
      required final QueueRecordStatus status}) = _$QueueRecordImpl;
  const _QueueRecord._() : super._();

  @override
  int get localSubjectID;
  @override
  String get onlineTableID;
  @override
  int get studentRowNumber;
  @override
  DateTime get time;
  @override
  int? get workCount;
  @override
  QueueRecordStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$QueueRecordImplCopyWith<_$QueueRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
