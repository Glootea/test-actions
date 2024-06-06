part of 'queue_loading_container.dart';

/// Guide is in [LoadingContainer] description
abstract class LoadableCubit<T extends LoadableState> extends Cubit<T> {
  LoadableCubit(super.initialState);

  void onEndLoading();
}

enum LoadingState {
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

abstract interface class LoadableState {
  const LoadableState(this.isStateLoading);
  final LoadingState isStateLoading;
}
