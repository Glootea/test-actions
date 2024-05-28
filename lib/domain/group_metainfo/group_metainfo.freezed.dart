// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_metainfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupMetaInfoState {
  String get groupName => throw _privateConstructorUsedError;
  String get headmasterName => throw _privateConstructorUsedError;
  List<int> get adminIDs => throw _privateConstructorUsedError;
  bool get useAttendance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupMetaInfoStateCopyWith<GroupMetaInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMetaInfoStateCopyWith<$Res> {
  factory $GroupMetaInfoStateCopyWith(
          GroupMetaInfoState value, $Res Function(GroupMetaInfoState) then) =
      _$GroupMetaInfoStateCopyWithImpl<$Res, GroupMetaInfoState>;
  @useResult
  $Res call(
      {String groupName,
      String headmasterName,
      List<int> adminIDs,
      bool useAttendance});
}

/// @nodoc
class _$GroupMetaInfoStateCopyWithImpl<$Res, $Val extends GroupMetaInfoState>
    implements $GroupMetaInfoStateCopyWith<$Res> {
  _$GroupMetaInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? headmasterName = null,
    Object? adminIDs = null,
    Object? useAttendance = null,
  }) {
    return _then(_value.copyWith(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      headmasterName: null == headmasterName
          ? _value.headmasterName
          : headmasterName // ignore: cast_nullable_to_non_nullable
              as String,
      adminIDs: null == adminIDs
          ? _value.adminIDs
          : adminIDs // ignore: cast_nullable_to_non_nullable
              as List<int>,
      useAttendance: null == useAttendance
          ? _value.useAttendance
          : useAttendance // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupMetaInfoStateImplCopyWith<$Res>
    implements $GroupMetaInfoStateCopyWith<$Res> {
  factory _$$GroupMetaInfoStateImplCopyWith(_$GroupMetaInfoStateImpl value,
          $Res Function(_$GroupMetaInfoStateImpl) then) =
      __$$GroupMetaInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupName,
      String headmasterName,
      List<int> adminIDs,
      bool useAttendance});
}

/// @nodoc
class __$$GroupMetaInfoStateImplCopyWithImpl<$Res>
    extends _$GroupMetaInfoStateCopyWithImpl<$Res, _$GroupMetaInfoStateImpl>
    implements _$$GroupMetaInfoStateImplCopyWith<$Res> {
  __$$GroupMetaInfoStateImplCopyWithImpl(_$GroupMetaInfoStateImpl _value,
      $Res Function(_$GroupMetaInfoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? headmasterName = null,
    Object? adminIDs = null,
    Object? useAttendance = null,
  }) {
    return _then(_$GroupMetaInfoStateImpl(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      headmasterName: null == headmasterName
          ? _value.headmasterName
          : headmasterName // ignore: cast_nullable_to_non_nullable
              as String,
      adminIDs: null == adminIDs
          ? _value._adminIDs
          : adminIDs // ignore: cast_nullable_to_non_nullable
              as List<int>,
      useAttendance: null == useAttendance
          ? _value.useAttendance
          : useAttendance // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GroupMetaInfoStateImpl implements _GroupMetaInfoState {
  const _$GroupMetaInfoStateImpl(
      {required this.groupName,
      required this.headmasterName,
      required final List<int> adminIDs,
      required this.useAttendance})
      : _adminIDs = adminIDs;

  @override
  final String groupName;
  @override
  final String headmasterName;
  final List<int> _adminIDs;
  @override
  List<int> get adminIDs {
    if (_adminIDs is EqualUnmodifiableListView) return _adminIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminIDs);
  }

  @override
  final bool useAttendance;

  @override
  String toString() {
    return 'GroupMetaInfoState(groupName: $groupName, headmasterName: $headmasterName, adminIDs: $adminIDs, useAttendance: $useAttendance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMetaInfoStateImpl &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.headmasterName, headmasterName) ||
                other.headmasterName == headmasterName) &&
            const DeepCollectionEquality().equals(other._adminIDs, _adminIDs) &&
            (identical(other.useAttendance, useAttendance) ||
                other.useAttendance == useAttendance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupName, headmasterName,
      const DeepCollectionEquality().hash(_adminIDs), useAttendance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMetaInfoStateImplCopyWith<_$GroupMetaInfoStateImpl> get copyWith =>
      __$$GroupMetaInfoStateImplCopyWithImpl<_$GroupMetaInfoStateImpl>(
          this, _$identity);
}

abstract class _GroupMetaInfoState implements GroupMetaInfoState {
  const factory _GroupMetaInfoState(
      {required final String groupName,
      required final String headmasterName,
      required final List<int> adminIDs,
      required final bool useAttendance}) = _$GroupMetaInfoStateImpl;

  @override
  String get groupName;
  @override
  String get headmasterName;
  @override
  List<int> get adminIDs;
  @override
  bool get useAttendance;
  @override
  @JsonKey(ignore: true)
  _$$GroupMetaInfoStateImplCopyWith<_$GroupMetaInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
