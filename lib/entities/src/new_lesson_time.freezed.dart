// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_lesson_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewWeeklyLessonEntity {
  int get id => throw _privateConstructorUsedError;
  List<int> get weekdays => throw _privateConstructorUsedError;
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  TimeOfDay get endTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewWeeklyLessonEntityCopyWith<NewWeeklyLessonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewWeeklyLessonEntityCopyWith<$Res> {
  factory $NewWeeklyLessonEntityCopyWith(NewWeeklyLessonEntity value,
          $Res Function(NewWeeklyLessonEntity) then) =
      _$NewWeeklyLessonEntityCopyWithImpl<$Res, NewWeeklyLessonEntity>;
  @useResult
  $Res call(
      {int id, List<int> weekdays, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class _$NewWeeklyLessonEntityCopyWithImpl<$Res,
        $Val extends NewWeeklyLessonEntity>
    implements $NewWeeklyLessonEntityCopyWith<$Res> {
  _$NewWeeklyLessonEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekdays = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weekdays: null == weekdays
          ? _value.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewWeeklyLessonEntityImplCopyWith<$Res>
    implements $NewWeeklyLessonEntityCopyWith<$Res> {
  factory _$$NewWeeklyLessonEntityImplCopyWith(
          _$NewWeeklyLessonEntityImpl value,
          $Res Function(_$NewWeeklyLessonEntityImpl) then) =
      __$$NewWeeklyLessonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, List<int> weekdays, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class __$$NewWeeklyLessonEntityImplCopyWithImpl<$Res>
    extends _$NewWeeklyLessonEntityCopyWithImpl<$Res,
        _$NewWeeklyLessonEntityImpl>
    implements _$$NewWeeklyLessonEntityImplCopyWith<$Res> {
  __$$NewWeeklyLessonEntityImplCopyWithImpl(_$NewWeeklyLessonEntityImpl _value,
      $Res Function(_$NewWeeklyLessonEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekdays = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$NewWeeklyLessonEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc

class _$NewWeeklyLessonEntityImpl extends _NewWeeklyLessonEntity {
  const _$NewWeeklyLessonEntityImpl(
      {required this.id,
      required final List<int> weekdays,
      required this.startTime,
      required this.endTime})
      : _weekdays = weekdays,
        super._();

  @override
  final int id;
  final List<int> _weekdays;
  @override
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  final TimeOfDay startTime;
  @override
  final TimeOfDay endTime;

  @override
  String toString() {
    return 'NewWeeklyLessonEntity(id: $id, weekdays: $weekdays, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewWeeklyLessonEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_weekdays), startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewWeeklyLessonEntityImplCopyWith<_$NewWeeklyLessonEntityImpl>
      get copyWith => __$$NewWeeklyLessonEntityImplCopyWithImpl<
          _$NewWeeklyLessonEntityImpl>(this, _$identity);
}

abstract class _NewWeeklyLessonEntity extends NewWeeklyLessonEntity {
  const factory _NewWeeklyLessonEntity(
      {required final int id,
      required final List<int> weekdays,
      required final TimeOfDay startTime,
      required final TimeOfDay endTime}) = _$NewWeeklyLessonEntityImpl;
  const _NewWeeklyLessonEntity._() : super._();

  @override
  int get id;
  @override
  List<int> get weekdays;
  @override
  TimeOfDay get startTime;
  @override
  TimeOfDay get endTime;
  @override
  @JsonKey(ignore: true)
  _$$NewWeeklyLessonEntityImplCopyWith<_$NewWeeklyLessonEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewDatedLessonEntity {
  int get id => throw _privateConstructorUsedError;
  List<DateTime> get dates => throw _privateConstructorUsedError;
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  TimeOfDay get endTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewDatedLessonEntityCopyWith<NewDatedLessonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewDatedLessonEntityCopyWith<$Res> {
  factory $NewDatedLessonEntityCopyWith(NewDatedLessonEntity value,
          $Res Function(NewDatedLessonEntity) then) =
      _$NewDatedLessonEntityCopyWithImpl<$Res, NewDatedLessonEntity>;
  @useResult
  $Res call(
      {int id, List<DateTime> dates, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class _$NewDatedLessonEntityCopyWithImpl<$Res,
        $Val extends NewDatedLessonEntity>
    implements $NewDatedLessonEntityCopyWith<$Res> {
  _$NewDatedLessonEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dates = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewDatedLessonEntityImplCopyWith<$Res>
    implements $NewDatedLessonEntityCopyWith<$Res> {
  factory _$$NewDatedLessonEntityImplCopyWith(_$NewDatedLessonEntityImpl value,
          $Res Function(_$NewDatedLessonEntityImpl) then) =
      __$$NewDatedLessonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, List<DateTime> dates, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class __$$NewDatedLessonEntityImplCopyWithImpl<$Res>
    extends _$NewDatedLessonEntityCopyWithImpl<$Res, _$NewDatedLessonEntityImpl>
    implements _$$NewDatedLessonEntityImplCopyWith<$Res> {
  __$$NewDatedLessonEntityImplCopyWithImpl(_$NewDatedLessonEntityImpl _value,
      $Res Function(_$NewDatedLessonEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dates = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$NewDatedLessonEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dates: null == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc

class _$NewDatedLessonEntityImpl extends _NewDatedLessonEntity {
  const _$NewDatedLessonEntityImpl(
      {required this.id,
      required final List<DateTime> dates,
      required this.startTime,
      required this.endTime})
      : _dates = dates,
        super._();

  @override
  final int id;
  final List<DateTime> _dates;
  @override
  List<DateTime> get dates {
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dates);
  }

  @override
  final TimeOfDay startTime;
  @override
  final TimeOfDay endTime;

  @override
  String toString() {
    return 'NewDatedLessonEntity(id: $id, dates: $dates, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewDatedLessonEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._dates, _dates) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_dates), startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewDatedLessonEntityImplCopyWith<_$NewDatedLessonEntityImpl>
      get copyWith =>
          __$$NewDatedLessonEntityImplCopyWithImpl<_$NewDatedLessonEntityImpl>(
              this, _$identity);
}

abstract class _NewDatedLessonEntity extends NewDatedLessonEntity {
  const factory _NewDatedLessonEntity(
      {required final int id,
      required final List<DateTime> dates,
      required final TimeOfDay startTime,
      required final TimeOfDay endTime}) = _$NewDatedLessonEntityImpl;
  const _NewDatedLessonEntity._() : super._();

  @override
  int get id;
  @override
  List<DateTime> get dates;
  @override
  TimeOfDay get startTime;
  @override
  TimeOfDay get endTime;
  @override
  @JsonKey(ignore: true)
  _$$NewDatedLessonEntityImplCopyWith<_$NewDatedLessonEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
