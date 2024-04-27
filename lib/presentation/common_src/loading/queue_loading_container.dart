import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/new_domain/today_screen_cubit.dart';
import 'package:queue/presentation/common_src/loading/loading_animation.dart';

/// Creates loading animation while cubit state's [LoadingState] != [LoadingState.ended], then displays child widget
class LoadingContainer<B extends StateStreamable<S>, S extends LoadableState> extends StatelessWidget {
  final Widget child;
  final LoadableCubit cubit;
  const LoadingContainer({
    required this.child,
    required this.cubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, LoadingState>(
        selector: (state) => state.isLoading,
        builder: (context, state) {
          return AnimatedCrossFade(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            crossFadeState: state != LoadingState.ended ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) => topChild,
            firstChild: Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: LoadingAnimation(
                  state: state,
                  afterAnimationEnd: cubit.endLoading,
                ),
              ),
            ),
            secondChild: child,
          );
        });
  }
}
