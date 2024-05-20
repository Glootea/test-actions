import 'dart:async';

import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/main/page/today_screen/today_screen_cubit.dart';
import 'package:rive/rive.dart';

class LoadingAnimation extends StatefulWidget {
  final LoadingState state;
  final VoidCallback afterAnimationEnd;
  const LoadingAnimation({required this.state, required this.afterAnimationEnd, super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  /// Timer and _states for checking if loaded state has already been reached, even before initialization
  late final Timer _timer;
  final List<LoadingState> _states = [];

  SMIBool? endTrigger;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'main',
      onStateChange: _onRiveStateChange,
    )!;

    artboard.addController(controller);

    controller.findInput<bool>('to background')?.value = false;

    endTrigger = controller.findInput<bool>('to end') as SMIBool;
  }

  void _onRiveStateChange(String stateMachineName, String stateName) {
    switch (stateName) {
      case 'End':
        Future.delayed(const Duration(milliseconds: 1500 ~/ 1.8), () => widget.afterAnimationEnd());
    }
  }

  void handleLoadingState(LoadingState state) {
    _states.add(state);
    if (_states.contains(LoadingState.loaded)) {
      endTrigger?.value = true;
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_states.contains(LoadingState.loaded)) {
        endTrigger?.value = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    handleLoadingState(widget.state);
    return RiveAnimation.asset(
      'assets/queue.riv', //TODO: change exit animation speed to 1.5
      stateMachines: const ['main'],
      onInit: (artboard) => _onRiveInit(artboard),
    );
  }
}
