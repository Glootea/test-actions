// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodayScreenState {
// required List<Lesson> lessonList,
  SeparatedLessons get separatedLessons => throw _privateConstructorUsedError;
  LoadingState get isLoading => throw _privateConstructorUsedError;
  DialogData? get dialogData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodayScreenStateCopyWith<TodayScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayScreenStateCopyWith<$Res> {
  factory $TodayScreenStateCopyWith(
          TodayScreenState value, $Res Function(TodayScreenState) then) =
      _$TodayScreenStateCopyWithImpl<$Res, TodayScreenState>;
  @useResult
  $Res call(
      {SeparatedLessons separatedLessons,
      LoadingState isLoading,
      DialogData? dialogData});
}

/// @nodoc
class _$TodayScreenStateCopyWithImpl<$Res, $Val extends TodayScreenState>
    implements $TodayScreenStateCopyWith<$Res> {
  _$TodayScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? separatedLessons = null,
    Object? isLoading = null,
    Object? dialogData = freezed,
  }) {
    return _then(_value.copyWith(
      separatedLessons: null == separatedLessons
          ? _value.separatedLessons
          : separatedLessons // ignore: cast_nullable_to_non_nullable
              as SeparatedLessons,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      dialogData: freezed == dialogData
          ? _value.dialogData
          : dialogData // ignore: cast_nullable_to_non_nullable
              as DialogData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainScreenStateImplCopyWith<$Res>
    implements $TodayScreenStateCopyWith<$Res> {
  factory _$$MainScreenStateImplCopyWith(_$MainScreenStateImpl value,
          $Res Function(_$MainScreenStateImpl) then) =
      __$$MainScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SeparatedLessons separatedLessons,
      LoadingState isLoading,
      DialogData? dialogData});
}

/// @nodoc
class __$$MainScreenStateImplCopyWithImpl<$Res>
    extends _$TodayScreenStateCopyWithImpl<$Res, _$MainScreenStateImpl>
    implements _$$MainScreenStateImplCopyWith<$Res> {
  __$$MainScreenStateImplCopyWithImpl(
      _$MainScreenStateImpl _value, $Res Function(_$MainScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? separatedLessons = null,
    Object? isLoading = null,
    Object? dialogData = freezed,
  }) {
    return _then(_$MainScreenStateImpl(
      separatedLessons: null == separatedLessons
          ? _value.separatedLessons
          : separatedLessons // ignore: cast_nullable_to_non_nullable
              as SeparatedLessons,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as LoadingState,
      dialogData: freezed == dialogData
          ? _value.dialogData
          : dialogData // ignore: cast_nullable_to_non_nullable
              as DialogData?,
    ));
  }
}

/// @nodoc

class _$MainScreenStateImpl extends _MainScreenState {
  const _$MainScreenStateImpl(
      {required this.separatedLessons,
      this.isLoading = LoadingState.loaded,
      this.dialogData})
      : super._();

// required List<Lesson> lessonList,
  @override
  final SeparatedLessons separatedLessons;
  @override
  @JsonKey()
  final LoadingState isLoading;
  @override
  final DialogData? dialogData;

  @override
  String toString() {
    return 'TodayScreenState(separatedLessons: $separatedLessons, isLoading: $isLoading, dialogData: $dialogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainScreenStateImpl &&
            (identical(other.separatedLessons, separatedLessons) ||
                other.separatedLessons == separatedLessons) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.dialogData, dialogData) ||
                other.dialogData == dialogData));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, separatedLessons, isLoading, dialogData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainScreenStateImplCopyWith<_$MainScreenStateImpl> get copyWith =>
      __$$MainScreenStateImplCopyWithImpl<_$MainScreenStateImpl>(
          this, _$identity);
}

abstract class _MainScreenState extends TodayScreenState {
  const factory _MainScreenState(
      {required final SeparatedLessons separatedLessons,
      final LoadingState isLoading,
      final DialogData? dialogData}) = _$MainScreenStateImpl;
  const _MainScreenState._() : super._();

  @override // required List<Lesson> lessonList,
  SeparatedLessons get separatedLessons;
  @override
  LoadingState get isLoading;
  @override
  DialogData? get dialogData;
  @override
  @JsonKey(ignore: true)
  _$$MainScreenStateImplCopyWith<_$MainScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
