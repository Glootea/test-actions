part of 'queue_loading_container.dart';

/// Guide is in [LoadingContainer] discription
abstract class LoadableCubit<T extends LoadableState> extends Cubit<T> {
  LoadableCubit(super.initialState);

  void endLoading();
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
  final LoadingState isStateLoading;
  const LoadableState(this.isStateLoading);
}
