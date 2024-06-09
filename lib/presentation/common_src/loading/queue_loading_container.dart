import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';
part 'loadable_cubit.dart';
part 'loading_animation.dart';

/// Creates loading animation while cubit state's [LoadingStateEnum] != [LoadingStateEnum.ended], then displays child widget
///
/// User guide:
/// 1. Create cubit that extends [LoadableCubit]
/// 2. Create states that extends [LoadableState]
///    - 2.1 Initial state should be with isStateLoading = [LoadingStateEnum.started]
///    - 2.2 When data is loaded, emit state with isStateLoading = [LoadingStateEnum.loaded]
///    - 2.3 Then end animation plays and and cubit internally calls [LoadableCubit.onEndLoading],
///       that will emit state with isStateLoading = [LoadingStateEnum.ended],
///       that will display content. So endLoading must be overridden in child class
///       to emit state with main content after loading
/// 3. Wrap page in [LoadingContainer]
class LoadingContainer<B extends StateStreamable<S>, S extends LoadableState> extends StatelessWidget {
  const LoadingContainer({
    required this.child,
    required this.cubit,
    this.loadingStageText,
    super.key,
  });
  final Widget child;
  final LoadableCubit cubit;
  final Widget? loadingStageText;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, LoadingStateEnum>(
      selector: (state) => state.isStateLoading,
      builder: (context, state) {
        log(state.toString());
        return AnimatedCrossFade(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 500),
          crossFadeState: state == LoadingStateEnum.started || state == LoadingStateEnum.loaded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => Center(child: topChild),
          firstChild: Scaffold(
            body: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: LoadingAnimation(
                      state: state,
                      afterAnimationEnd: cubit.onEndLoading,
                    ),
                  ),
                  const Gap(16),
                  loadingStageText ?? Container(),
                ],
              ),
            ),
          ),
          secondChild: child,
        );
      },
    );
  }
}
