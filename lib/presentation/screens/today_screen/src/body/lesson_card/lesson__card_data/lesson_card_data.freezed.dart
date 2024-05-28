// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LessonCardData {
  Lesson get lesson => throw _privateConstructorUsedError;
  bool get attended => throw _privateConstructorUsedError;
  QueueData? get queueData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LessonCardDataCopyWith<LessonCardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCardDataCopyWith<$Res> {
  factory $LessonCardDataCopyWith(
          LessonCardData value, $Res Function(LessonCardData) then) =
      _$LessonCardDataCopyWithImpl<$Res, LessonCardData>;
  @useResult
  $Res call({Lesson lesson, bool attended, QueueData? queueData});

  $LessonCopyWith<$Res> get lesson;
  $QueueDataCopyWith<$Res>? get queueData;
}

/// @nodoc
class _$LessonCardDataCopyWithImpl<$Res, $Val extends LessonCardData>
    implements $LessonCardDataCopyWith<$Res> {
  _$LessonCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? attended = null,
    Object? queueData = freezed,
  }) {
    return _then(_value.copyWith(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      attended: null == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as bool,
      queueData: freezed == queueData
          ? _value.queueData
          : queueData // ignore: cast_nullable_to_non_nullable
              as QueueData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LessonCopyWith<$Res> get lesson {
    return $LessonCopyWith<$Res>(_value.lesson, (value) {
      return _then(_value.copyWith(lesson: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueDataCopyWith<$Res>? get queueData {
    if (_value.queueData == null) {
      return null;
    }

    return $QueueDataCopyWith<$Res>(_value.queueData!, (value) {
      return _then(_value.copyWith(queueData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LessonCardDataImplCopyWith<$Res>
    implements $LessonCardDataCopyWith<$Res> {
  factory _$$LessonCardDataImplCopyWith(_$LessonCardDataImpl value,
          $Res Function(_$LessonCardDataImpl) then) =
      __$$LessonCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Lesson lesson, bool attended, QueueData? queueData});

  @override
  $LessonCopyWith<$Res> get lesson;
  @override
  $QueueDataCopyWith<$Res>? get queueData;
}

/// @nodoc
class __$$LessonCardDataImplCopyWithImpl<$Res>
    extends _$LessonCardDataCopyWithImpl<$Res, _$LessonCardDataImpl>
    implements _$$LessonCardDataImplCopyWith<$Res> {
  __$$LessonCardDataImplCopyWithImpl(
      _$LessonCardDataImpl _value, $Res Function(_$LessonCardDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? attended = null,
    Object? queueData = freezed,
  }) {
    return _then(_$LessonCardDataImpl(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      attended: null == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as bool,
      queueData: freezed == queueData
          ? _value.queueData
          : queueData // ignore: cast_nullable_to_non_nullable
              as QueueData?,
    ));
  }
}

/// @nodoc

class _$LessonCardDataImpl extends _LessonCardData {
  const _$LessonCardDataImpl(
      {required this.lesson, required this.attended, required this.queueData})
      : super._();

  @override
  final Lesson lesson;
  @override
  final bool attended;
  @override
  final QueueData? queueData;

  @override
  String toString() {
    return 'LessonCardData(lesson: $lesson, attended: $attended, queueData: $queueData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonCardDataImpl &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.attended, attended) ||
                other.attended == attended) &&
            (identical(other.queueData, queueData) ||
                other.queueData == queueData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lesson, attended, queueData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonCardDataImplCopyWith<_$LessonCardDataImpl> get copyWith =>
      __$$LessonCardDataImplCopyWithImpl<_$LessonCardDataImpl>(
          this, _$identity);
}

abstract class _LessonCardData extends LessonCardData {
  const factory _LessonCardData(
      {required final Lesson lesson,
      required final bool attended,
      required final QueueData? queueData}) = _$LessonCardDataImpl;
  const _LessonCardData._() : super._();

  @override
  Lesson get lesson;
  @override
  bool get attended;
  @override
  QueueData? get queueData;
  @override
  @JsonKey(ignore: true)
  _$$LessonCardDataImplCopyWith<_$LessonCardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
