import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class ConnectionStatusWidget extends StatefulWidget {
  const ConnectionStatusWidget({super.key});

  @override
  State<ConnectionStatusWidget> createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> with TickerProviderStateMixin {
  bool shouldUpdate = false;
  late DataBaseService database;
  late AnimationController _controller;
  late Timer _timer;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool get isConnected =>
      (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 60));
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      context.read<QueueBloc>().add(UserAuthenticatedEvent());
      final temp = await (Connectivity().checkConnectivity());
      if (temp != connectivityResult) {
        setState(() {
          connectivityResult = temp;
        });
      }
    });
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<QueueBloc>(),
      buildWhen: (previous, current) => (previous as MainState).updateEnabled != (current as MainState).updateEnabled,
      builder: (context, bloc) => FutureBuilder(
          future: context.read<QueueBloc>().getUpdateEnabled,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return RepaintBoundary(child: TickerButton(StepTween(begin: 60, end: 0).animate(_controller), true));
            }
            return const NoUpdateButton();
          }),
    );
  }
}

// class TickerButton extends StatefulWidget {
//   const TickerButton({super.key});

//   @override
//   State<TickerButton> createState() => _TickerButtonState();
// }

// class _TickerButtonState extends State<TickerButton> {
//   late final Timer timer;
//   ConnectivityResult connectivityResult = ConnectivityResult.none;
//   bool get isConnected => (connectivityResult == ConnectivityResult.wifi ||
//       connectivityResult == ConnectivityResult.ethernet);
//   @override
//   void initState() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (timer.tick % 60 == 0) {
//         context.read<QueueBloc>().add(UserAuthenticatedEvent());
//       }
//       if (timer.tick % 60 == 1 || timer.tick % 60 == 50) {
//         connectivityResult = await (Connectivity().checkConnectivity());
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//         onPressed: () {
//           context.read<QueueBloc>().add(ToggleUpdateEvent());
//         },
//         child: Row(children: [
//           Icon(isConnected ? Icons.wifi_outlined : Icons.wifi_off_outlined,
//               color: isConnected
//                   ? Theme.of(context).colorScheme.primary
//                   : Theme.of(context).colorScheme.error),
//           const Gap(16),
//           Center(
//             child: Text((60 - timer.tick % 60).toString(),
//                 style: Theme.of(context).textTheme.bodyMedium),
//           ),
//         ]));
//   }
// }

class TickerButton extends AnimatedWidget {
  const TickerButton(this.animation, this.isConnected, {super.key}) : super(listenable: animation);
  final Animation<int> animation;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          context.read<QueueBloc>().add(ToggleUpdateEvent());
        },
        child: Row(children: [
          Icon(isConnected ? Icons.wifi_outlined : Icons.wifi_off_outlined,
              color: isConnected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error),
          const Gap(16),
          Center(
            child: Text(animation.value.toString(), style: Theme.of(context).textTheme.bodyMedium),
          ),
        ]));
  }
}

class NoUpdateButton extends StatelessWidget {
  const NoUpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          context.read<QueueBloc>().add(ToggleUpdateEvent());
        },
        child: Icon(
          Icons.update_disabled_outlined,
          color: Theme.of(context).colorScheme.error,
        ));
  }
}
