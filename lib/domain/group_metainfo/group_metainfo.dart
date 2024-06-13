import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/extension.dart';
part 'group_metainfo.freezed.dart';

class GroupMetaInfoCubit extends Cubit<GroupMetaInfoState> {
  GroupMetaInfoCubit._(this._keyValueStorage) : super(GroupMetaInfoState.empty());
  final KeyValueStorage _keyValueStorage;
  bool get useAttendance => state.useAttendance;

  static Future<GroupMetaInfoCubit> create(KeyValueStorage keyValueStorage) async {
    final cubit = GroupMetaInfoCubit._(keyValueStorage);
    await cubit._init();
    return cubit;
  }

  Future<void> _init() async {
    await _getLocalData().then(emit);
    await Future.delayed(
      const Duration(seconds: 1),
      () => emit(
        state.copyWith(useAttendance: true),
      ),
    ); // TODO: remove after testing and implementing online GroupMetaInfo
  }

  Future<GroupMetaInfoState> _getLocalData() async {
    final data = await (
      _keyValueStorage.get(StoredValues.groupName),
      _keyValueStorage.get(StoredValues.headmasterName),
      _keyValueStorage.get(StoredValues.adminIDs),
      _keyValueStorage.get(StoredValues.useAttendance)
    ).wait;

    return GroupMetaInfoState(
      groupName: data.$1 ?? '',
      headmasterName: data.$2 ?? '',
      adminIDs: data.$3?.toIntList ?? [],
      useAttendance: bool.parse(data.$4 ?? 'false'),
    );
  }

  Future<GroupMetaInfoState> _fetchOnlineData() async {
    //TODO: fetch online data using OnlineDataBase in init method after local
    throw UnimplementedError();
  }
}

@freezed
class GroupMetaInfoState with _$GroupMetaInfoState {
  const factory GroupMetaInfoState({
    required String groupName,
    required String headmasterName,
    required List<int> adminIDs,
    required bool useAttendance,
  }) = _GroupMetaInfoState;

  factory GroupMetaInfoState.empty() => const GroupMetaInfoState(
        adminIDs: [],
        useAttendance: false,
        groupName: '',
        headmasterName: '',
      );
}
