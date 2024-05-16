// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_card_queue_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LessonCardQueueData {
  int get queueLength => throw _privateConstructorUsedError;
  int get queuePosition => throw _privateConstructorUsedError;

  /// Описание очереди: "Вы 3 в очереди после Name".
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LessonCardQueueDataCopyWith<LessonCardQueueData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCardQueueDataCopyWith<$Res> {
  factory $LessonCardQueueDataCopyWith(
          LessonCardQueueData value, $Res Function(LessonCardQueueData) then) =
      _$LessonCardQueueDataCopyWithImpl<$Res, LessonCardQueueData>;
  @useResult
  $Res call({int queueLength, int queuePosition, String message});
}

/// @nodoc
class _$LessonCardQueueDataCopyWithImpl<$Res, $Val extends LessonCardQueueData>
    implements $LessonCardQueueDataCopyWith<$Res> {
  _$LessonCardQueueDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueLength = null,
    Object? queuePosition = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      queueLength: null == queueLength
          ? _value.queueLength
          : queueLength // ignore: cast_nullable_to_non_nullable
              as int,
      queuePosition: null == queuePosition
          ? _value.queuePosition
          : queuePosition // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonCardQueueDataImplCopyWith<$Res>
    implements $LessonCardQueueDataCopyWith<$Res> {
  factory _$$LessonCardQueueDataImplCopyWith(_$LessonCardQueueDataImpl value,
          $Res Function(_$LessonCardQueueDataImpl) then) =
      __$$LessonCardQueueDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int queueLength, int queuePosition, String message});
}

/// @nodoc
class __$$LessonCardQueueDataImplCopyWithImpl<$Res>
    extends _$LessonCardQueueDataCopyWithImpl<$Res, _$LessonCardQueueDataImpl>
    implements _$$LessonCardQueueDataImplCopyWith<$Res> {
  __$$LessonCardQueueDataImplCopyWithImpl(_$LessonCardQueueDataImpl _value,
      $Res Function(_$LessonCardQueueDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueLength = null,
    Object? queuePosition = null,
    Object? message = null,
  }) {
    return _then(_$LessonCardQueueDataImpl(
      queueLength: null == queueLength
          ? _value.queueLength
          : queueLength // ignore: cast_nullable_to_non_nullable
              as int,
      queuePosition: null == queuePosition
          ? _value.queuePosition
          : queuePosition // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LessonCardQueueDataImpl implements _LessonCardQueueData {
  const _$LessonCardQueueDataImpl(
      {required this.queueLength,
      required this.queuePosition,
      required this.message});

  @override
  final int queueLength;
  @override
  final int queuePosition;

  /// Описание очереди: "Вы 3 в очереди после Name".
  @override
  final String message;

  @override
  String toString() {
    return 'LessonCardQueueData(queueLength: $queueLength, queuePosition: $queuePosition, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonCardQueueDataImpl &&
            (identical(other.queueLength, queueLength) ||
                other.queueLength == queueLength) &&
            (identical(other.queuePosition, queuePosition) ||
                other.queuePosition == queuePosition) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, queueLength, queuePosition, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonCardQueueDataImplCopyWith<_$LessonCardQueueDataImpl> get copyWith =>
      __$$LessonCardQueueDataImplCopyWithImpl<_$LessonCardQueueDataImpl>(
          this, _$identity);
}

abstract class _LessonCardQueueData implements LessonCardQueueData {
  const factory _LessonCardQueueData(
      {required final int queueLength,
      required final int queuePosition,
      required final String message}) = _$LessonCardQueueDataImpl;

  @override
  int get queueLength;
  @override
  int get queuePosition;
  @override

  /// Описание очереди: "Вы 3 в очереди после Name".
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$LessonCardQueueDataImplCopyWith<_$LessonCardQueueDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
