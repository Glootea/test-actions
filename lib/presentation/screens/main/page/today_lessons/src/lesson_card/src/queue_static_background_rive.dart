import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class QueueStaticBackgroundRive extends StatelessWidget {
  final double size;
  final bool userInQueue;
  final Stream<bool>? actionStream;
  const QueueStaticBackgroundRive({
    super.key,
    required this.size,
    required this.userInQueue,
    this.actionStream,
  });

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
        child: RiveAnimation.asset("assets/queue.riv",
            alignment: const Alignment(0.7, 0.5),
            stateMachines: const ['main'],
            placeHolder: Container(),
            fit: BoxFit.contain, onInit: (artboard) {
          print("Init Rive");
          final controller = StateMachineController.fromArtboard(
            artboard,
            'main',
            onStateChange: (stateMachineName, stateName) => print(stateName),
          );

          artboard.addController(controller!);
          controller.findInput<bool>('play start')?.value = true;
          controller.findInput<bool>('to background')?.value = true;
          final endTrigger = controller.getBoolInput('to end') as SMIBool;
          actionStream?.listen(
            (event) async {
              if (event) {
                print(controller.getTriggerInput('restart')?.value);
                controller.getTriggerInput('restart')?.fire();
                print(controller.getTriggerInput('restart')?.value);
                endTrigger.value = false;
              } else {
                endTrigger.value = true;
                print(controller.getTriggerInput('restart')?.value);
              }
            },
          );
          artboard.forEachComponent(
            (child) {
              // print(child.name);
              if (child is Shape) {
                final Shape shape = child;
                if (shape.name == 'Head' || shape.name == 'Body') {
                  shape.strokes.first.paint.colorFilter = ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6), BlendMode.src);
                  if (userInQueue && child.parent?.name == "Person 2") {
                    shape.strokes.first.paint.colorFilter =
                        ColorFilter.mode(Theme.of(context).colorScheme.error.withOpacity(0.6), BlendMode.src);
                  }
                }
              }
            },
          );
        }),
      ),
    );
  }
}
