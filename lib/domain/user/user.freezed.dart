// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$User {
  String get name => throw _privateConstructorUsedError;
  int get rowNumber => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) = _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({String name, int rowNumber, bool isAdmin});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rowNumber = null,
    Object? isAdmin = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rowNumber: null == rowNumber
          ? _value.rowNumber
          : rowNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(_$UserImpl value, $Res Function(_$UserImpl) then) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int rowNumber, bool isAdmin});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$UserImpl> implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rowNumber = null,
    Object? isAdmin = null,
  }) {
    return _then(_$UserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rowNumber: null == rowNumber
          ? _value.rowNumber
          : rowNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserImpl implements _User {
  const _$UserImpl({required this.name, required this.rowNumber, required this.isAdmin});

  @override
  final String name;
  @override
  final int rowNumber;
  @override
  final bool isAdmin;

  @override
  String toString() {
    return 'User(name: $name, rowNumber: $rowNumber, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rowNumber, rowNumber) || other.rowNumber == rowNumber) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, rowNumber, isAdmin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith => __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User implements User {
  const factory _User({required final String name, required final int rowNumber, required final bool isAdmin}) =
      _$UserImpl;

  @override
  String get name;
  @override
  int get rowNumber;
  @override
  bool get isAdmin;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith => throw _privateConstructorUsedError;
}
