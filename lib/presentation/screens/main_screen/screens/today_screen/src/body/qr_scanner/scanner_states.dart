import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

sealed class ScannerPageState implements LoadableState {
  @override
  String? get loadingStateText => 'Загрузка сканера...';
}

class LoadingLibraryState extends ScannerPageState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.started;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

class LoadedLibraryState extends ScannerPageState {
  LoadedLibraryState();
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.ended;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

class ScanningState extends ScannerPageState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.noLoading;
}

class ScannedState extends ScannerPageState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.started;
}

class LoadedState extends ScannerPageState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.loaded;
  ShowResultState createShowResultState() {
    return ShowResultState();
  }
}

class ShowResultState extends LoadedState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.ended;
}

class ErrorState extends ScannerPageState {
  @override
  LoadingStateEnum get isStateLoading => LoadingStateEnum.error;
}
