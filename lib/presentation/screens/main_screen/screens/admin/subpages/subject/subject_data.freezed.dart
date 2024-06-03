// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubjectData {
  String get name => throw _privateConstructorUsedError;
  bool get useWorkCount => throw _privateConstructorUsedError;
  bool get useAutoDelete => throw _privateConstructorUsedError;
  double? get queueKoef => throw _privateConstructorUsedError;
  List<LessonTime> get lessonTimes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubjectDataCopyWith<SubjectData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectDataCopyWith<$Res> {
  factory $SubjectDataCopyWith(
          SubjectData value, $Res Function(SubjectData) then) =
      _$SubjectDataCopyWithImpl<$Res, SubjectData>;
  @useResult
  $Res call(
      {String name,
      bool useWorkCount,
      bool useAutoDelete,
      double? queueKoef,
      List<LessonTime> lessonTimes});
}

/// @nodoc
class _$SubjectDataCopyWithImpl<$Res, $Val extends SubjectData>
    implements $SubjectDataCopyWith<$Res> {
  _$SubjectDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? useWorkCount = null,
    Object? useAutoDelete = null,
    Object? queueKoef = freezed,
    Object? lessonTimes = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      useWorkCount: null == useWorkCount
          ? _value.useWorkCount
          : useWorkCount // ignore: cast_nullable_to_non_nullable
              as bool,
      useAutoDelete: null == useAutoDelete
          ? _value.useAutoDelete
          : useAutoDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      queueKoef: freezed == queueKoef
          ? _value.queueKoef
          : queueKoef // ignore: cast_nullable_to_non_nullable
              as double?,
      lessonTimes: null == lessonTimes
          ? _value.lessonTimes
          : lessonTimes // ignore: cast_nullable_to_non_nullable
              as List<LessonTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectDataImplCopyWith<$Res>
    implements $SubjectDataCopyWith<$Res> {
  factory _$$SubjectDataImplCopyWith(
          _$SubjectDataImpl value, $Res Function(_$SubjectDataImpl) then) =
      __$$SubjectDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      bool useWorkCount,
      bool useAutoDelete,
      double? queueKoef,
      List<LessonTime> lessonTimes});
}

/// @nodoc
class __$$SubjectDataImplCopyWithImpl<$Res>
    extends _$SubjectDataCopyWithImpl<$Res, _$SubjectDataImpl>
    implements _$$SubjectDataImplCopyWith<$Res> {
  __$$SubjectDataImplCopyWithImpl(
      _$SubjectDataImpl _value, $Res Function(_$SubjectDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? useWorkCount = null,
    Object? useAutoDelete = null,
    Object? queueKoef = freezed,
    Object? lessonTimes = null,
  }) {
    return _then(_$SubjectDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      useWorkCount: null == useWorkCount
          ? _value.useWorkCount
          : useWorkCount // ignore: cast_nullable_to_non_nullable
              as bool,
      useAutoDelete: null == useAutoDelete
          ? _value.useAutoDelete
          : useAutoDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      queueKoef: freezed == queueKoef
          ? _value.queueKoef
          : queueKoef // ignore: cast_nullable_to_non_nullable
              as double?,
      lessonTimes: null == lessonTimes
          ? _value._lessonTimes
          : lessonTimes // ignore: cast_nullable_to_non_nullable
              as List<LessonTime>,
    ));
  }
}

/// @nodoc

class _$SubjectDataImpl implements _SubjectData {
  const _$SubjectDataImpl(
      {required this.name,
      required this.useWorkCount,
      required this.useAutoDelete,
      required this.queueKoef,
      required final List<LessonTime> lessonTimes})
      : _lessonTimes = lessonTimes;

  @override
  final String name;
  @override
  final bool useWorkCount;
  @override
  final bool useAutoDelete;
  @override
  final double? queueKoef;
  final List<LessonTime> _lessonTimes;
  @override
  List<LessonTime> get lessonTimes {
    if (_lessonTimes is EqualUnmodifiableListView) return _lessonTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessonTimes);
  }

  @override
  String toString() {
    return 'SubjectData(name: $name, useWorkCount: $useWorkCount, useAutoDelete: $useAutoDelete, queueKoef: $queueKoef, lessonTimes: $lessonTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.useWorkCount, useWorkCount) ||
                other.useWorkCount == useWorkCount) &&
            (identical(other.useAutoDelete, useAutoDelete) ||
                other.useAutoDelete == useAutoDelete) &&
            (identical(other.queueKoef, queueKoef) ||
                other.queueKoef == queueKoef) &&
            const DeepCollectionEquality()
                .equals(other._lessonTimes, _lessonTimes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      useWorkCount,
      useAutoDelete,
      queueKoef,
      const DeepCollectionEquality().hash(_lessonTimes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectDataImplCopyWith<_$SubjectDataImpl> get copyWith =>
      __$$SubjectDataImplCopyWithImpl<_$SubjectDataImpl>(this, _$identity);
}

abstract class _SubjectData implements SubjectData {
  const factory _SubjectData(
      {required final String name,
      required final bool useWorkCount,
      required final bool useAutoDelete,
      required final double? queueKoef,
      required final List<LessonTime> lessonTimes}) = _$SubjectDataImpl;

  @override
  String get name;
  @override
  bool get useWorkCount;
  @override
  bool get useAutoDelete;
  @override
  double? get queueKoef;
  @override
  List<LessonTime> get lessonTimes;
  @override
  @JsonKey(ignore: true)
  _$$SubjectDataImplCopyWith<_$SubjectDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
