import 'package:queue/data/google_drive_provider/google_drive_provider.dart';
import 'package:queue/data/google_drive_provider/online_file_skeleton_filler.dart';
import 'package:queue/data/online_database_strings.dart';
import 'package:queue/domain/user/user.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

class InitLoadingCubit extends LoadableCubit {
  InitLoadingCubit(this._userCubit) : super(const DefaultNoLoadingState());
  final UserCubit _userCubit;
  @override
  void onEndLoading() {
    emit(const DefaultEndedState());
  }

  Future<void> headManGroupCreationIntent() async {
    emit(const InputDataState());
  }

  Future<void> headManCreateGroup(GroupCreationData data) async {
    print('Login flow started');
    await _userCubit.login(name: data.headMasterName, rowNumber: 2, isAdmin: true);
    final googleSignIn = _userCubit.state!.getOnlineAccount<GoogleOnlineAccount>()!.googleSignIn;
    if (googleSignIn.currentUser == null) {
      await _userCubit.signInSingle<GoogleOnlineAccount>();
    }

    emit(const DefaultLoadingState(loadingStateText: 'Поиск данных на диске'));

    final googleDriveProvider = await GoogleDriveProvider.create(googleSignIn);
    final foundInfoFile = await googleDriveProvider.fileExistsInAppFolder(OnlineDatabaseStrings.infoFileName);
    if (foundInfoFile) {
      emit(const DefaultLoadedState(loadingStateText: 'Данные найдены'));
    } else {
      emit(const DefaultLoadingState(loadingStateText: 'Данные не найдены'));

      final infoFileID =
          await googleDriveProvider.createFile(name: OnlineDatabaseStrings.infoFileName, type: FileType.spreadsheet);
      emit(const DefaultLoadingState(loadingStateText: 'Файл для данных создан'));

      await OnlineFileSkeletonFiller.fillInfoFile(infoFileID);
      emit(const DefaultLoadedState(loadingStateText: 'Данные созданы'));
    }
    //TODO: fill already existing data
    await Future.delayed(const Duration(seconds: 1));
    emit(const DefaultLoadedState());
  }

  Future<void> headMasterLogin() async {
    await _userCubit.loginTemp();
    await _userCubit.signInSingle<GoogleOnlineAccount>();
    emit(const DefaultLoadingState(loadingStateText: 'Поиск данных на диске'));
    final googleSignIn =
        _userCubit.state!.getOnlineAccount<GoogleOnlineAccount>()!.googleSignIn; //TODO: fix throw on cancel login
    final googleDriveProvider = await GoogleDriveProvider.create(googleSignIn);
    final foundInfoFile = await googleDriveProvider.fileExistsInAppFolder(OnlineDatabaseStrings.infoFileName);
    if (foundInfoFile) {
      emit(const DefaultLoadedState(loadingStateText: 'Данные найдены'));
      await Future.delayed(const Duration(seconds: 1));
      emit(const DefaultLoadedState());
    } else {
      emit(const DefaultLoadingState(loadingStateText: 'Необходимая информация на вашем Google Drive не найдена.'));
      await Future.delayed(const Duration(seconds: 3), headManGroupCreationIntent);
    }
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
