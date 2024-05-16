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
  QueueRecordStatus? get userRecordStatus => throw _privateConstructorUsedError;

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
  $Res call({Lesson lesson, QueueRecordStatus? userRecordStatus});

  $LessonCopyWith<$Res> get lesson;
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
    Object? userRecordStatus = freezed,
  }) {
    return _then(_value.copyWith(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      userRecordStatus: freezed == userRecordStatus
          ? _value.userRecordStatus
          : userRecordStatus // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus?,
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
abstract class _$$LessonCardDataImplCopyWith<$Res>
    implements $LessonCardDataCopyWith<$Res> {
  factory _$$LessonCardDataImplCopyWith(_$LessonCardDataImpl value,
          $Res Function(_$LessonCardDataImpl) then) =
      __$$LessonCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Lesson lesson, QueueRecordStatus? userRecordStatus});

  @override
  $LessonCopyWith<$Res> get lesson;
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
    Object? userRecordStatus = freezed,
  }) {
    return _then(_$LessonCardDataImpl(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      userRecordStatus: freezed == userRecordStatus
          ? _value.userRecordStatus
          : userRecordStatus // ignore: cast_nullable_to_non_nullable
              as QueueRecordStatus?,
    ));
  }
}

/// @nodoc

class _$LessonCardDataImpl extends _LessonCardData {
  const _$LessonCardDataImpl(
      {required this.lesson, required this.userRecordStatus})
      : super._();

  @override
  final Lesson lesson;
  @override
  final QueueRecordStatus? userRecordStatus;

  @override
  String toString() {
    return 'LessonCardData(lesson: $lesson, userRecordStatus: $userRecordStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonCardDataImpl &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.userRecordStatus, userRecordStatus) ||
                other.userRecordStatus == userRecordStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lesson, userRecordStatus);

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
          required final QueueRecordStatus? userRecordStatus}) =
      _$LessonCardDataImpl;
  const _LessonCardData._() : super._();

  @override
  Lesson get lesson;
  @override
  QueueRecordStatus? get userRecordStatus;
  @override
  @JsonKey(ignore: true)
  _$$LessonCardDataImplCopyWith<_$LessonCardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
