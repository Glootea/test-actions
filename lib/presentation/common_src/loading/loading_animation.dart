part of 'queue_loading_container.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({required this.state, required this.afterAnimationEnd, super.key});
  final LoadingStateEnum state;
  final VoidCallback afterAnimationEnd;

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  /// Timer and _states for checking if loaded state has already been reached, even before initialization
  late final Timer _timer;
  final List<LoadingStateEnum> _states = [];

  SMIBool? endTrigger;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'main',
      onStateChange: _onRiveStateChange,
    )!;

    artboard.addController(controller);

    controller.findInput<bool>('to background')?.value = false;

    endTrigger = controller.findInput<bool>('to end')! as SMIBool;
  }

  void _onRiveStateChange(String stateMachineName, String stateName) {
    switch (stateName) {
      case 'End':
        Future.delayed(const Duration(milliseconds: 1500 ~/ 1.8), () => widget.afterAnimationEnd());
    }
  }

  void handleLoadingState(LoadingStateEnum state) {
    _states.add(state);
    if (_states.contains(LoadingStateEnum.loaded)) {
      endTrigger?.value = true;
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_states.contains(LoadingStateEnum.loaded)) {
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
      onInit: _onRiveInit,
    );
  }
}

// @Deprecated('Remove when rive is supported in wasm and windows')
// class _TempLoadingAnimationState extends _LoadingAnimationState {
//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 300,
//       child: ColoredBox(color: Colors.blue),
//     );
//   }

//   @override
//   void handleLoadingState(LoadingState state) {
//     _states.add(state);
//     if (_states.contains(LoadingState.loaded)) {
//       Future.delayed(const Duration(milliseconds: 1500 ~/ 1.8), () => widget.afterAnimationEnd());
//     }
//   }
// }
