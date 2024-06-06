import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';

class InitLoadingCubit extends LoadableCubit {
  InitLoadingCubit() : super(NotLoadedState());

  @override
  void onEndLoading() {
    emit(EndedState());
  }

  Future<void> startLoading() async {
    return Future.delayed(const Duration(seconds: 3), () => emit(LoadedState()));
  }
}

class NotLoadedState implements LoadableState {
  @override
  LoadingState get isStateLoading => LoadingState.started;
}

class LoadedState implements LoadableState {
  @override
  LoadingState get isStateLoading => LoadingState.loaded;
}

class EndedState implements LoadableState {
  @override
  LoadingState get isStateLoading => LoadingState.ended;
}
