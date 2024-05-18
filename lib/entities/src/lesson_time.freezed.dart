// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeeklyLessonEntity {
  int get id => throw _privateConstructorUsedError;
  List<int> get weekdays => throw _privateConstructorUsedError;
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  TimeOfDay get endTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeeklyLessonEntityCopyWith<WeeklyLessonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyLessonEntityCopyWith<$Res> {
  factory $WeeklyLessonEntityCopyWith(
          WeeklyLessonEntity value, $Res Function(WeeklyLessonEntity) then) =
      _$WeeklyLessonEntityCopyWithImpl<$Res, WeeklyLessonEntity>;
  @useResult
  $Res call(
      {int id, List<int> weekdays, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class _$WeeklyLessonEntityCopyWithImpl<$Res, $Val extends WeeklyLessonEntity>
    implements $WeeklyLessonEntityCopyWith<$Res> {
  _$WeeklyLessonEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$WeeklyLessonEntityImplCopyWith<$Res>
    implements $WeeklyLessonEntityCopyWith<$Res> {
  factory _$$WeeklyLessonEntityImplCopyWith(_$WeeklyLessonEntityImpl value,
          $Res Function(_$WeeklyLessonEntityImpl) then) =
      __$$WeeklyLessonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, List<int> weekdays, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class __$$WeeklyLessonEntityImplCopyWithImpl<$Res>
    extends _$WeeklyLessonEntityCopyWithImpl<$Res, _$WeeklyLessonEntityImpl>
    implements _$$WeeklyLessonEntityImplCopyWith<$Res> {
  __$$WeeklyLessonEntityImplCopyWithImpl(_$WeeklyLessonEntityImpl _value,
      $Res Function(_$WeeklyLessonEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekdays = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$WeeklyLessonEntityImpl(
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

class _$WeeklyLessonEntityImpl extends _WeeklyLessonEntity {
  const _$WeeklyLessonEntityImpl(
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
    return 'WeeklyLessonEntity(id: $id, weekdays: $weekdays, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyLessonEntityImpl &&
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
  _$$WeeklyLessonEntityImplCopyWith<_$WeeklyLessonEntityImpl> get copyWith =>
      __$$WeeklyLessonEntityImplCopyWithImpl<_$WeeklyLessonEntityImpl>(
          this, _$identity);
}

abstract class _WeeklyLessonEntity extends WeeklyLessonEntity {
  const factory _WeeklyLessonEntity(
      {required final int id,
      required final List<int> weekdays,
      required final TimeOfDay startTime,
      required final TimeOfDay endTime}) = _$WeeklyLessonEntityImpl;
  const _WeeklyLessonEntity._() : super._();

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
  _$$WeeklyLessonEntityImplCopyWith<_$WeeklyLessonEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DatedLessonEntity {
  int get id => throw _privateConstructorUsedError;
  List<DateTime> get dates => throw _privateConstructorUsedError;
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  TimeOfDay get endTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DatedLessonEntityCopyWith<DatedLessonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatedLessonEntityCopyWith<$Res> {
  factory $DatedLessonEntityCopyWith(
          DatedLessonEntity value, $Res Function(DatedLessonEntity) then) =
      _$DatedLessonEntityCopyWithImpl<$Res, DatedLessonEntity>;
  @useResult
  $Res call(
      {int id, List<DateTime> dates, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class _$DatedLessonEntityCopyWithImpl<$Res, $Val extends DatedLessonEntity>
    implements $DatedLessonEntityCopyWith<$Res> {
  _$DatedLessonEntityCopyWithImpl(this._value, this._then);

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
    implements $DatedLessonEntityCopyWith<$Res> {
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
    extends _$DatedLessonEntityCopyWithImpl<$Res, _$NewDatedLessonEntityImpl>
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
    return 'DatedLessonEntity(id: $id, dates: $dates, startTime: $startTime, endTime: $endTime)';
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

abstract class _NewDatedLessonEntity extends DatedLessonEntity {
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
