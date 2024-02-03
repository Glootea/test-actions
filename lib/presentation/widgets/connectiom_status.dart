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

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  bool shouldUpdate = false;
  late DataBaseService database;
  ValueNotifier<int> value = ValueNotifier(60);
  late Timer timer;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool get isConnected =>
      (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet);
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      value.value = 60 - (timer.tick % 60);
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
    value.dispose();
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
              return TickerButton(isConnected, value);
            }
            return const NoUpdateButton();
          }),
    );
  }
}

class TickerButton extends AnimatedWidget {
  const TickerButton(this.isConnected, this.timer, {super.key}) : super(listenable: timer);
  final bool isConnected;
  final ValueNotifier timer;
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
            child: Text(timer.value.toString(), style: Theme.of(context).textTheme.bodyMedium),
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
