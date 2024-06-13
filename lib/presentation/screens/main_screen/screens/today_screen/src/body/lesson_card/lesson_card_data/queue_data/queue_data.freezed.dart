// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QueueData {
  List<QueueRecord> get queueRecordList => throw _privateConstructorUsedError;
  int get queueLength => throw _privateConstructorUsedError;
  int? get userPosition => throw _privateConstructorUsedError;
  QueueRecord? get userRecord => throw _privateConstructorUsedError;
  bool get live => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QueueDataCopyWith<QueueData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueDataCopyWith<$Res> {
  factory $QueueDataCopyWith(QueueData value, $Res Function(QueueData) then) =
      _$QueueDataCopyWithImpl<$Res, QueueData>;
  @useResult
  $Res call(
      {List<QueueRecord> queueRecordList,
      int queueLength,
      int? userPosition,
      QueueRecord? userRecord,
      bool live});

  $QueueRecordCopyWith<$Res>? get userRecord;
}

/// @nodoc
class _$QueueDataCopyWithImpl<$Res, $Val extends QueueData>
    implements $QueueDataCopyWith<$Res> {
  _$QueueDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueRecordList = null,
    Object? queueLength = null,
    Object? userPosition = freezed,
    Object? userRecord = freezed,
    Object? live = null,
  }) {
    return _then(_value.copyWith(
      queueRecordList: null == queueRecordList
          ? _value.queueRecordList
          : queueRecordList // ignore: cast_nullable_to_non_nullable
              as List<QueueRecord>,
      queueLength: null == queueLength
          ? _value.queueLength
          : queueLength // ignore: cast_nullable_to_non_nullable
              as int,
      userPosition: freezed == userPosition
          ? _value.userPosition
          : userPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      userRecord: freezed == userRecord
          ? _value.userRecord
          : userRecord // ignore: cast_nullable_to_non_nullable
              as QueueRecord?,
      live: null == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueRecordCopyWith<$Res>? get userRecord {
    if (_value.userRecord == null) {
      return null;
    }

    return $QueueRecordCopyWith<$Res>(_value.userRecord!, (value) {
      return _then(_value.copyWith(userRecord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueDataImplCopyWith<$Res>
    implements $QueueDataCopyWith<$Res> {
  factory _$$QueueDataImplCopyWith(
          _$QueueDataImpl value, $Res Function(_$QueueDataImpl) then) =
      __$$QueueDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<QueueRecord> queueRecordList,
      int queueLength,
      int? userPosition,
      QueueRecord? userRecord,
      bool live});

  @override
  $QueueRecordCopyWith<$Res>? get userRecord;
}

/// @nodoc
class __$$QueueDataImplCopyWithImpl<$Res>
    extends _$QueueDataCopyWithImpl<$Res, _$QueueDataImpl>
    implements _$$QueueDataImplCopyWith<$Res> {
  __$$QueueDataImplCopyWithImpl(
      _$QueueDataImpl _value, $Res Function(_$QueueDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueRecordList = null,
    Object? queueLength = null,
    Object? userPosition = freezed,
    Object? userRecord = freezed,
    Object? live = null,
  }) {
    return _then(_$QueueDataImpl(
      queueRecordList: null == queueRecordList
          ? _value._queueRecordList
          : queueRecordList // ignore: cast_nullable_to_non_nullable
              as List<QueueRecord>,
      queueLength: null == queueLength
          ? _value.queueLength
          : queueLength // ignore: cast_nullable_to_non_nullable
              as int,
      userPosition: freezed == userPosition
          ? _value.userPosition
          : userPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      userRecord: freezed == userRecord
          ? _value.userRecord
          : userRecord // ignore: cast_nullable_to_non_nullable
              as QueueRecord?,
      live: null == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$QueueDataImpl extends _QueueData {
  const _$QueueDataImpl(
      {required final List<QueueRecord> queueRecordList,
      required this.queueLength,
      required this.userPosition,
      required this.userRecord,
      required this.live})
      : _queueRecordList = queueRecordList,
        super._();

  final List<QueueRecord> _queueRecordList;
  @override
  List<QueueRecord> get queueRecordList {
    if (_queueRecordList is EqualUnmodifiableListView) return _queueRecordList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queueRecordList);
  }

  @override
  final int queueLength;
  @override
  final int? userPosition;
  @override
  final QueueRecord? userRecord;
  @override
  final bool live;

  @override
  String toString() {
    return 'QueueData(queueRecordList: $queueRecordList, queueLength: $queueLength, userPosition: $userPosition, userRecord: $userRecord, live: $live)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueDataImpl &&
            const DeepCollectionEquality()
                .equals(other._queueRecordList, _queueRecordList) &&
            (identical(other.queueLength, queueLength) ||
                other.queueLength == queueLength) &&
            (identical(other.userPosition, userPosition) ||
                other.userPosition == userPosition) &&
            (identical(other.userRecord, userRecord) ||
                other.userRecord == userRecord) &&
            (identical(other.live, live) || other.live == live));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_queueRecordList),
      queueLength,
      userPosition,
      userRecord,
      live);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueDataImplCopyWith<_$QueueDataImpl> get copyWith =>
      __$$QueueDataImplCopyWithImpl<_$QueueDataImpl>(this, _$identity);
}

abstract class _QueueData extends QueueData {
  const factory _QueueData(
      {required final List<QueueRecord> queueRecordList,
      required final int queueLength,
      required final int? userPosition,
      required final QueueRecord? userRecord,
      required final bool live}) = _$QueueDataImpl;
  const _QueueData._() : super._();

  @override
  List<QueueRecord> get queueRecordList;
  @override
  int get queueLength;
  @override
  int? get userPosition;
  @override
  QueueRecord? get userRecord;
  @override
  bool get live;
  @override
  @JsonKey(ignore: true)
  _$$QueueDataImplCopyWith<_$QueueDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
