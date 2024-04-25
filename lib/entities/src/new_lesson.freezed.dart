// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewLesson {
  String get name => throw _privateConstructorUsedError;
  int get localID => throw _privateConstructorUsedError;
  String get onlineTableID => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewLessonCopyWith<NewLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewLessonCopyWith<$Res> {
  factory $NewLessonCopyWith(NewLesson value, $Res Function(NewLesson) then) =
      _$NewLessonCopyWithImpl<$Res, NewLesson>;
  @useResult
  $Res call(
      {String name,
      int localID,
      String onlineTableID,
      DateTime startTime,
      DateTime endTime});
}

/// @nodoc
class _$NewLessonCopyWithImpl<$Res, $Val extends NewLesson>
    implements $NewLessonCopyWith<$Res> {
  _$NewLessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? localID = null,
    Object? onlineTableID = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      localID: null == localID
          ? _value.localID
          : localID // ignore: cast_nullable_to_non_nullable
              as int,
      onlineTableID: null == onlineTableID
          ? _value.onlineTableID
          : onlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewLessonImplCopyWith<$Res>
    implements $NewLessonCopyWith<$Res> {
  factory _$$NewLessonImplCopyWith(
          _$NewLessonImpl value, $Res Function(_$NewLessonImpl) then) =
      __$$NewLessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int localID,
      String onlineTableID,
      DateTime startTime,
      DateTime endTime});
}

/// @nodoc
class __$$NewLessonImplCopyWithImpl<$Res>
    extends _$NewLessonCopyWithImpl<$Res, _$NewLessonImpl>
    implements _$$NewLessonImplCopyWith<$Res> {
  __$$NewLessonImplCopyWithImpl(
      _$NewLessonImpl _value, $Res Function(_$NewLessonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? localID = null,
    Object? onlineTableID = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$NewLessonImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      localID: null == localID
          ? _value.localID
          : localID // ignore: cast_nullable_to_non_nullable
              as int,
      onlineTableID: null == onlineTableID
          ? _value.onlineTableID
          : onlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$NewLessonImpl implements _NewLesson {
  const _$NewLessonImpl(
      {required this.name,
      required this.localID,
      required this.onlineTableID,
      required this.startTime,
      required this.endTime});

  @override
  final String name;
  @override
  final int localID;
  @override
  final String onlineTableID;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;

  @override
  String toString() {
    return 'NewLesson(name: $name, localID: $localID, onlineTableID: $onlineTableID, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewLessonImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.localID, localID) || other.localID == localID) &&
            (identical(other.onlineTableID, onlineTableID) ||
                other.onlineTableID == onlineTableID) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, localID, onlineTableID, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewLessonImplCopyWith<_$NewLessonImpl> get copyWith =>
      __$$NewLessonImplCopyWithImpl<_$NewLessonImpl>(this, _$identity);
}

abstract class _NewLesson implements NewLesson {
  const factory _NewLesson(
      {required final String name,
      required final int localID,
      required final String onlineTableID,
      required final DateTime startTime,
      required final DateTime endTime}) = _$NewLessonImpl;

  @override
  String get name;
  @override
  int get localID;
  @override
  String get onlineTableID;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  @JsonKey(ignore: true)
  _$$NewLessonImplCopyWith<_$NewLessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
