// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudentEntity {
  String get name => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  int get onlineTableRowNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StudentEntityCopyWith<StudentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentEntityCopyWith<$Res> {
  factory $StudentEntityCopyWith(
          StudentEntity value, $Res Function(StudentEntity) then) =
      _$StudentEntityCopyWithImpl<$Res, StudentEntity>;
  @useResult
  $Res call({String name, bool isAdmin, int onlineTableRowNumber});
}

/// @nodoc
class _$StudentEntityCopyWithImpl<$Res, $Val extends StudentEntity>
    implements $StudentEntityCopyWith<$Res> {
  _$StudentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isAdmin = null,
    Object? onlineTableRowNumber = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      onlineTableRowNumber: null == onlineTableRowNumber
          ? _value.onlineTableRowNumber
          : onlineTableRowNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentEntityImplCopyWith<$Res>
    implements $StudentEntityCopyWith<$Res> {
  factory _$$StudentEntityImplCopyWith(
          _$StudentEntityImpl value, $Res Function(_$StudentEntityImpl) then) =
      __$$StudentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, bool isAdmin, int onlineTableRowNumber});
}

/// @nodoc
class __$$StudentEntityImplCopyWithImpl<$Res>
    extends _$StudentEntityCopyWithImpl<$Res, _$StudentEntityImpl>
    implements _$$StudentEntityImplCopyWith<$Res> {
  __$$StudentEntityImplCopyWithImpl(
      _$StudentEntityImpl _value, $Res Function(_$StudentEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isAdmin = null,
    Object? onlineTableRowNumber = null,
  }) {
    return _then(_$StudentEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      onlineTableRowNumber: null == onlineTableRowNumber
          ? _value.onlineTableRowNumber
          : onlineTableRowNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StudentEntityImpl implements _StudentEntity {
  const _$StudentEntityImpl(
      {required this.name,
      required this.isAdmin,
      required this.onlineTableRowNumber});

  @override
  final String name;
  @override
  final bool isAdmin;
  @override
  final int onlineTableRowNumber;

  @override
  String toString() {
    return 'StudentEntity(name: $name, isAdmin: $isAdmin, onlineTableRowNumber: $onlineTableRowNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.onlineTableRowNumber, onlineTableRowNumber) ||
                other.onlineTableRowNumber == onlineTableRowNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, isAdmin, onlineTableRowNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentEntityImplCopyWith<_$StudentEntityImpl> get copyWith =>
      __$$StudentEntityImplCopyWithImpl<_$StudentEntityImpl>(this, _$identity);
}

abstract class _StudentEntity implements StudentEntity {
  const factory _StudentEntity(
      {required final String name,
      required final bool isAdmin,
      required final int onlineTableRowNumber}) = _$StudentEntityImpl;

  @override
  String get name;
  @override
  bool get isAdmin;
  @override
  int get onlineTableRowNumber;
  @override
  @JsonKey(ignore: true)
  _$$StudentEntityImplCopyWith<_$StudentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
