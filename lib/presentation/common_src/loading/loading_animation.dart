import 'package:flutter/material.dart';
import 'package:queue/new_domain/today_screen_cubit.dart';
import 'package:rive/rive.dart';

class LoadingAnimation extends StatefulWidget {
  final LoadingState state;
  final VoidCallback afterAnimationEnd;
  const LoadingAnimation({required this.state, required this.afterAnimationEnd, super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  SMIBool? endTrigger;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'queue',
      onStateChange: (stateMachineName, stateName) => _onRiveStateChange(stateMachineName, stateName),
    )!;

    artboard.addController(controller);
    endTrigger = controller.findInput<bool>('To end') as SMIBool;
  }

  void _onRiveStateChange(String stateMachineName, String stateName) {
    switch (stateName) {
      case 'ExitState':
        widget.afterAnimationEnd();
    }
  }

  void handleLoadingState(LoadingState state) {
    if (state == LoadingState.loaded) {
      endTrigger?.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    handleLoadingState(widget.state);
    return RiveAnimation.asset(
      'assets/queue.riv', //TODO: change exit animation speed to 1.5
      stateMachines: const ['queue'],
      onInit: (artboard) => _onRiveInit(artboard),
    );
  }
}
