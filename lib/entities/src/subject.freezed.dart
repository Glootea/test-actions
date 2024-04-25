// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Subject {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get tableID => throw _privateConstructorUsedError;
  bool get autoDelete => throw _privateConstructorUsedError;
  bool get useWorkCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubjectCopyWith<Subject> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectCopyWith<$Res> {
  factory $SubjectCopyWith(Subject value, $Res Function(Subject) then) =
      _$SubjectCopyWithImpl<$Res, Subject>;
  @useResult
  $Res call(
      {int id,
      String name,
      String tableID,
      bool autoDelete,
      bool useWorkCount});
}

/// @nodoc
class _$SubjectCopyWithImpl<$Res, $Val extends Subject>
    implements $SubjectCopyWith<$Res> {
  _$SubjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tableID = null,
    Object? autoDelete = null,
    Object? useWorkCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tableID: null == tableID
          ? _value.tableID
          : tableID // ignore: cast_nullable_to_non_nullable
              as String,
      autoDelete: null == autoDelete
          ? _value.autoDelete
          : autoDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      useWorkCount: null == useWorkCount
          ? _value.useWorkCount
          : useWorkCount // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectImplCopyWith<$Res> implements $SubjectCopyWith<$Res> {
  factory _$$SubjectImplCopyWith(
          _$SubjectImpl value, $Res Function(_$SubjectImpl) then) =
      __$$SubjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String tableID,
      bool autoDelete,
      bool useWorkCount});
}

/// @nodoc
class __$$SubjectImplCopyWithImpl<$Res>
    extends _$SubjectCopyWithImpl<$Res, _$SubjectImpl>
    implements _$$SubjectImplCopyWith<$Res> {
  __$$SubjectImplCopyWithImpl(
      _$SubjectImpl _value, $Res Function(_$SubjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tableID = null,
    Object? autoDelete = null,
    Object? useWorkCount = null,
  }) {
    return _then(_$SubjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tableID: null == tableID
          ? _value.tableID
          : tableID // ignore: cast_nullable_to_non_nullable
              as String,
      autoDelete: null == autoDelete
          ? _value.autoDelete
          : autoDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      useWorkCount: null == useWorkCount
          ? _value.useWorkCount
          : useWorkCount // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SubjectImpl extends _Subject {
  const _$SubjectImpl(
      {required this.id,
      required this.name,
      required this.tableID,
      required this.autoDelete,
      required this.useWorkCount})
      : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final String tableID;
  @override
  final bool autoDelete;
  @override
  final bool useWorkCount;

  @override
  String toString() {
    return 'Subject(id: $id, name: $name, tableID: $tableID, autoDelete: $autoDelete, useWorkCount: $useWorkCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tableID, tableID) || other.tableID == tableID) &&
            (identical(other.autoDelete, autoDelete) ||
                other.autoDelete == autoDelete) &&
            (identical(other.useWorkCount, useWorkCount) ||
                other.useWorkCount == useWorkCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, tableID, autoDelete, useWorkCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectImplCopyWith<_$SubjectImpl> get copyWith =>
      __$$SubjectImplCopyWithImpl<_$SubjectImpl>(this, _$identity);
}

abstract class _Subject extends Subject {
  const factory _Subject(
      {required final int id,
      required final String name,
      required final String tableID,
      required final bool autoDelete,
      required final bool useWorkCount}) = _$SubjectImpl;
  const _Subject._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  String get tableID;
  @override
  bool get autoDelete;
  @override
  bool get useWorkCount;
  @override
  @JsonKey(ignore: true)
  _$$SubjectImplCopyWith<_$SubjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
