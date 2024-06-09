import 'package:queue/domain/user/user.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

class InitLoadingCubit extends LoadableCubit {
  InitLoadingCubit(this._userCubit) : super(const InputDataState());
  final UserCubit _userCubit;
  @override
  void onEndLoading() {
    emit(const DefaultEndedState());
  }

  Future<void> login(GroupCreationData data) async {
    print('Login flow started');
    await _userCubit.login(name: data.headMasterName, rowNumber: 2, isAdmin: true);
    await _userCubit.signInSingle<GoogleOnlineAccount>();

    emit(const DefaultLoadingState(loadingStateText: 'Поиск данных на диске'));
    await Future.delayed(const Duration(seconds: 3), () => emit(const DefaultLoadedState()));
  }
}

class NoUserState extends LoadableState {
  const NoUserState({this.errorMessage}) : super(LoadingStateEnum.noLoading);
  final String? errorMessage;
}

class InputDataState extends LoadableState {
  const InputDataState() : super(LoadingStateEnum.noLoading);
}

class GroupCreationData {
  const GroupCreationData({required this.groupName, required this.headMasterName});

  final String groupName;
  final String headMasterName;
}
