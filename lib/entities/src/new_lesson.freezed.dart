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
mixin _$Lesson {
  String get name => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError; // subjectLocalID
  String get subjectOnlineTableID => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;

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
      int id,
      String subjectOnlineTableID,
      String room});
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
    Object? id = null,
    Object? subjectOnlineTableID = null,
    Object? room = null,
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subjectOnlineTableID: null == subjectOnlineTableID
          ? _value.subjectOnlineTableID
          : subjectOnlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewLessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$NewLessonImplCopyWith(
          _$NewLessonImpl value, $Res Function(_$NewLessonImpl) then) =
      __$$NewLessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DateTime startTime,
      DateTime endTime,
      int id,
      String subjectOnlineTableID,
      String room});
}

/// @nodoc
class __$$NewLessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$NewLessonImpl>
    implements _$$NewLessonImplCopyWith<$Res> {
  __$$NewLessonImplCopyWithImpl(
      _$NewLessonImpl _value, $Res Function(_$NewLessonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? id = null,
    Object? subjectOnlineTableID = null,
    Object? room = null,
  }) {
    return _then(_$NewLessonImpl(
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subjectOnlineTableID: null == subjectOnlineTableID
          ? _value.subjectOnlineTableID
          : subjectOnlineTableID // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NewLessonImpl extends _NewLesson {
  const _$NewLessonImpl(
      {required this.name,
      required this.startTime,
      required this.endTime,
      required this.id,
      required this.subjectOnlineTableID,
      required this.room})
      : super._();

  @override
  final String name;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int id;
// subjectLocalID
  @override
  final String subjectOnlineTableID;
  @override
  final String room;

  @override
  String toString() {
    return 'Lesson(name: $name, startTime: $startTime, endTime: $endTime, id: $id, subjectOnlineTableID: $subjectOnlineTableID, room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewLessonImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subjectOnlineTableID, subjectOnlineTableID) ||
                other.subjectOnlineTableID == subjectOnlineTableID) &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, startTime, endTime, id, subjectOnlineTableID, room);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewLessonImplCopyWith<_$NewLessonImpl> get copyWith =>
      __$$NewLessonImplCopyWithImpl<_$NewLessonImpl>(this, _$identity);
}

abstract class _NewLesson extends Lesson {
  const factory _NewLesson(
      {required final String name,
      required final DateTime startTime,
      required final DateTime endTime,
      required final int id,
      required final String subjectOnlineTableID,
      required final String room}) = _$NewLessonImpl;
  const _NewLesson._() : super._();

  @override
  String get name;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get id;
  @override // subjectLocalID
  String get subjectOnlineTableID;
  @override
  String get room;
  @override
  @JsonKey(ignore: true)
  _$$NewLessonImplCopyWith<_$NewLessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
