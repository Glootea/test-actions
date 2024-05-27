import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

sealed class ScannerPageState implements LoadableState {}

class LoadingLibraryState extends ScannerPageState {
  @override
  LoadingState get isStateLoading => LoadingState.started;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

class LoadedLibraryState extends ScannerPageState {
  LoadedLibraryState();
  @override
  LoadingState get isStateLoading => LoadingState.ended;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

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
