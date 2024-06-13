// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Lesson {
  String get name => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get subjectLocalID => throw _privateConstructorUsedError;
  String get subjectOnlineTableID => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res, Lesson>;
  @useResult
  $Res call(
      {String name,
      DateTime startTime,
      DateTime endTime,
      int subjectLocalID,
      String subjectOnlineTableID});
}

/// @nodoc
class _$LessonCopyWithImpl<$Res, $Val extends Lesson>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? subjectLocalID = null,
    Object? subjectOnlineTableID = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subjectLocalID: null == subjectLocalID
          ? _value.subjectLocalID
          : subjectLocalID // ignore: cast_nullable_to_non_nullable
              as int,
      subjectOnlineTableID: null == subjectOnlineTableID
          ? _value.subjectOnlineTableID
          : subjectOnlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$LessonImplCopyWith(
          _$LessonImpl value, $Res Function(_$LessonImpl) then) =
      __$$LessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime startTime,
      DateTime endTime,
      int subjectLocalID,
      String subjectOnlineTableID});
}

/// @nodoc
class __$$LessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$LessonImpl>
    implements _$$LessonImplCopyWith<$Res> {
  __$$LessonImplCopyWithImpl(
      _$LessonImpl _value, $Res Function(_$LessonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? subjectLocalID = null,
    Object? subjectOnlineTableID = null,
  }) {
    return _then(_$LessonImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subjectLocalID: null == subjectLocalID
          ? _value.subjectLocalID
          : subjectLocalID // ignore: cast_nullable_to_non_nullable
              as int,
      subjectOnlineTableID: null == subjectOnlineTableID
          ? _value.subjectOnlineTableID
          : subjectOnlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LessonImpl extends _Lesson {
  const _$LessonImpl(
      {required this.name,
      required this.startTime,
      required this.endTime,
      required this.subjectLocalID,
      required this.subjectOnlineTableID})
      : super._();

  @override
  final String name;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int subjectLocalID;
  @override
  final String subjectOnlineTableID;

  @override
  String toString() {
    return 'Lesson(name: $name, startTime: $startTime, endTime: $endTime, subjectLocalID: $subjectLocalID, subjectOnlineTableID: $subjectOnlineTableID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.subjectLocalID, subjectLocalID) ||
                other.subjectLocalID == subjectLocalID) &&
            (identical(other.subjectOnlineTableID, subjectOnlineTableID) ||
                other.subjectOnlineTableID == subjectOnlineTableID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, startTime, endTime,
      subjectLocalID, subjectOnlineTableID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      __$$LessonImplCopyWithImpl<_$LessonImpl>(this, _$identity);
}

abstract class _Lesson extends Lesson {
  const factory _Lesson(
      {required final String name,
      required final DateTime startTime,
      required final DateTime endTime,
      required final int subjectLocalID,
      required final String subjectOnlineTableID}) = _$LessonImpl;
  const _Lesson._() : super._();

  @override
  String get name;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get subjectLocalID;
  @override
  String get subjectOnlineTableID;
  @override
  @JsonKey(ignore: true)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
