// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_queue_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewQueueRecord {
  int get localSubjectID => throw _privateConstructorUsedError;
  String get onlineTableID => throw _privateConstructorUsedError;
  int get studentRowNumber => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  int? get workCount => throw _privateConstructorUsedError;
  NewQueueRecordStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewQueueRecordCopyWith<NewQueueRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewQueueRecordCopyWith<$Res> {
  factory $NewQueueRecordCopyWith(
          NewQueueRecord value, $Res Function(NewQueueRecord) then) =
      _$NewQueueRecordCopyWithImpl<$Res, NewQueueRecord>;
  @useResult
  $Res call(
      {int localSubjectID,
      String onlineTableID,
      int studentRowNumber,
      DateTime time,
      int? workCount,
      NewQueueRecordStatus status});
}

/// @nodoc
class _$NewQueueRecordCopyWithImpl<$Res, $Val extends NewQueueRecord>
    implements $NewQueueRecordCopyWith<$Res> {
  _$NewQueueRecordCopyWithImpl(this._value, this._then);

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
              as NewQueueRecordStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewQueueRecordImplCopyWith<$Res>
    implements $NewQueueRecordCopyWith<$Res> {
  factory _$$NewQueueRecordImplCopyWith(_$NewQueueRecordImpl value,
          $Res Function(_$NewQueueRecordImpl) then) =
      __$$NewQueueRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int localSubjectID,
      String onlineTableID,
      int studentRowNumber,
      DateTime time,
      int? workCount,
      NewQueueRecordStatus status});
}

/// @nodoc
class __$$NewQueueRecordImplCopyWithImpl<$Res>
    extends _$NewQueueRecordCopyWithImpl<$Res, _$NewQueueRecordImpl>
    implements _$$NewQueueRecordImplCopyWith<$Res> {
  __$$NewQueueRecordImplCopyWithImpl(
      _$NewQueueRecordImpl _value, $Res Function(_$NewQueueRecordImpl) _then)
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
    return _then(_$NewQueueRecordImpl(
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
              as NewQueueRecordStatus,
    ));
  }
}

/// @nodoc

class _$NewQueueRecordImpl extends _NewQueueRecord {
  const _$NewQueueRecordImpl(
      {required this.localSubjectID,
      required this.onlineTableID,
      required this.studentRowNumber,
      required this.time,
      required this.workCount,
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
  final NewQueueRecordStatus status;

  @override
  String toString() {
    return 'NewQueueRecord(localSubjectID: $localSubjectID, onlineTableID: $onlineTableID, studentRowNumber: $studentRowNumber, time: $time, workCount: $workCount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewQueueRecordImpl &&
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
  _$$NewQueueRecordImplCopyWith<_$NewQueueRecordImpl> get copyWith =>
      __$$NewQueueRecordImplCopyWithImpl<_$NewQueueRecordImpl>(
          this, _$identity);
}

abstract class _NewQueueRecord extends NewQueueRecord {
  const factory _NewQueueRecord(
      {required final int localSubjectID,
      required final String onlineTableID,
      required final int studentRowNumber,
      required final DateTime time,
      required final int? workCount,
      required final NewQueueRecordStatus status}) = _$NewQueueRecordImpl;
  const _NewQueueRecord._() : super._();

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
  NewQueueRecordStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$NewQueueRecordImplCopyWith<_$NewQueueRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
