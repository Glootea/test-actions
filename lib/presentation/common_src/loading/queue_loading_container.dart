import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

part 'loadable_cubit.dart';
part 'loading_animation.dart';

/// Creates loading animation while cubit state's [LoadingState] != [LoadingState.ended], then displays child widget
///
/// User guide:
/// 1. Create cubit that extends [LoadableCubit]
/// 2. Create states that extends [LoadableState]
///    - 2.1 Initial state should be with isStateLoading = [LoadingState.started]
///    - 2.2 When data is loaded, emit state with isStateLoading = [LoadingState.loaded]
///    - 2.3 Then end animation plays and and cubit internally calls [LoadableCubit.onEndLoading],
///       that will emit state with isStateLoading = [LoadingState.ended],
///       that will display content. So endLoading must be overridden in child class
///       to emit state with main content after loading
/// 3. Wrap page in [LoadingContainer]
class LoadingContainer<B extends StateStreamable<S>, S extends LoadableState> extends StatelessWidget {
  const LoadingContainer({
    required this.child,
    required this.cubit,
    super.key,
  });
  final Widget child;
  final LoadableCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, LoadingState>(
      selector: (state) => state.isStateLoading,
      builder: (context, state) {
        log(state.toString());
        return AnimatedCrossFade(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 500),
          crossFadeState: state == LoadingState.started || state == LoadingState.loaded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => topChild,
          firstChild: Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: LoadingAnimation(
                state: state,
                afterAnimationEnd: cubit.onEndLoading,
              ),
            ),
          ),
          secondChild: child,
        );
      },
    );
  }
}
