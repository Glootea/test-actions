import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

@Deprecated("Don't overcomlicate card")
class QueueStaticBackgroundRive extends StatelessWidget {
  @Deprecated("Don't overcomlicate card")
  const QueueStaticBackgroundRive({
    required this.size,
    required this.userInQueue,
    super.key,
    this.actionStream,
  });
  final double size;
  final bool userInQueue;
  final Stream<bool>? actionStream;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: OverflowBox(
        minHeight: size,
        minWidth: size,
        maxHeight: size,
        maxWidth: size,
        child: RiveAnimation.asset(
          'assets/queue.riv',
          alignment: const Alignment(0.7, 0.5),
          stateMachines: const ['main'],
          placeHolder: Container(),
          fit: BoxFit.contain,
          onInit: (artboard) {
            if (kDebugMode) {
              print('Init Rive');
            }
            final controller = StateMachineController.fromArtboard(
              artboard,
              'main',
              onStateChange: (stateMachineName, stateName) {
                if (kDebugMode) print(stateName);
              },
            );

            artboard.addController(controller!);
            controller.findInput<bool>('play start')?.value = true;
            controller.findInput<bool>('to background')?.value = true;
            final endTrigger = controller.getBoolInput('to end')!;
            actionStream?.listen(
              (event) async {
                if (event) {
                  if (kDebugMode) {
                    print(controller.getTriggerInput('restart')?.value);
                  }
                  controller.getTriggerInput('restart')?.fire();
                  if (kDebugMode) {
                    print(controller.getTriggerInput('restart')?.value);
                  }
                  endTrigger.value = false;
                } else {
                  endTrigger.value = true;
                  if (kDebugMode) {
                    print(controller.getTriggerInput('restart')?.value);
                  }
                }
              },
            );
            artboard.forEachComponent(
              (child) {
                // print(child.name);
                if (child is Shape) {
                  final shape = child;
                  if (shape.name == 'Head' || shape.name == 'Body') {
                    shape.strokes.first.paint.colorFilter = ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                      BlendMode.src,
                    );
                    if (userInQueue && child.parent?.name == 'Person 2') {
                      shape.strokes.first.paint.colorFilter =
                          ColorFilter.mode(Theme.of(context).colorScheme.error.withOpacity(0.6), BlendMode.src);
                    }
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
