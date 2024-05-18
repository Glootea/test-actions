import 'package:queue/presentation/screens/main/main_screen_cubit.dart';

sealed class ScannerPageState implements LoadableState {}

class ScanningState extends ScannerPageState {
  @override
  LoadingState get isStateLoading => LoadingState.noLoading;
}

class ScannedState extends ScannerPageState {
  @override
  LoadingState get isStateLoading => LoadingState.started;
}

class LoadedState extends ScannerPageState {
  @override
  LoadingState get isStateLoading => LoadingState.loaded;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

class ShowResultState extends LoadedState {
  @override
  LoadingState get isStateLoading => LoadingState.ended;
}

class ErrorState extends ScannerPageState {
  @override
  LoadingState get isStateLoading => LoadingState.error;
}
