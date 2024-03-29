import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class ConnectionStatusButton extends StatefulWidget {
  const ConnectionStatusButton({super.key});

  @override
  State<ConnectionStatusButton> createState() => _ConnectionStatusButtonState();
}

class _ConnectionStatusButtonState extends State<ConnectionStatusButton> {
  bool shouldUpdate = false;
  ValueNotifier<int> timerValue = ValueNotifier(60);
  late Timer timer;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool get isConnected =>
      (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet);
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      timerValue.value = 60 - (timer.tick % 60);
      if (timer.tick % 60 == 0) {
        context.read<QueueBloc>().add(UserAuthenticatedEvent());
      }
      if (timer.tick % 10 == 0 || timer.tick == 1) {
        final temp = await (Connectivity().checkConnectivity());
        if (temp != connectivityResult) {
          setState(() {
            connectivityResult = temp;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timerValue.dispose();
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
            if (snapshot.hasData && snapshot.data == true && context.mounted) {
              return TickerButton(isConnected, timerValue);
            }
            return const NoUpdateButton();
          }),
    );
  }
}

class TickerButton extends AnimatedWidget {
  const TickerButton(this.isConnected, this.timerValue, {super.key}) : super(listenable: timerValue);
  final bool isConnected;
  final ValueNotifier timerValue;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton(
        onPressed: () {
          context.read<QueueBloc>().add(ToggleUpdateEvent());
        },
        child: Row(children: [
          Icon(isConnected ? Icons.wifi_outlined : Icons.wifi_off_outlined,
              color: isConnected ? colorScheme.primary : colorScheme.error),
          const Gap(16),
          Center(
            child: Text(timerValue.value.toString(), style: Theme.of(context).textTheme.bodyMedium),
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
