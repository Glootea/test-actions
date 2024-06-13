part of 'queue_loading_container.dart';

/// Guide is in [LoadingContainer] description
abstract class LoadableCubit<T extends LoadableState> extends Cubit<T> {
  LoadableCubit(super.initialState);

  void onEndLoading();
}

enum LoadingStateEnum {
  /// Used to display loading phase of loading animation
  started,

  /// Used to display endind phase of loading animation
  loaded,

  /// Used to display content after loading
  ended,

  /// Used to display error message after error during loading animation
  error,
  noLoading
}

class LoadableState {
  const LoadableState(this.isStateLoading, {this.loadingStateText});
  final LoadingStateEnum isStateLoading;
  final String? loadingStateText;
}

class DefaultNoLoadingState extends LoadableState {
  const DefaultNoLoadingState() : super(LoadingStateEnum.noLoading);
}

class DefaultLoadingState extends LoadableState {
  const DefaultLoadingState({super.loadingStateText}) : super(LoadingStateEnum.started);
}

class DefaultLoadedState extends LoadableState {
  const DefaultLoadedState({super.loadingStateText}) : super(LoadingStateEnum.loaded);
}

class DefaultEndedState extends LoadableState {
  const DefaultEndedState({super.loadingStateText}) : super(LoadingStateEnum.ended);
}
