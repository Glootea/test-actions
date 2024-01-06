import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class ConnectionStatusWidget extends StatefulWidget {
  const ConnectionStatusWidget({super.key});

  @override
  State<ConnectionStatusWidget> createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  late final Timer timer;
  String text = '';
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool get isConnected => (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet);
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (timer.tick % 60 == 0) {
        context.read<QueueBloc>().add(UserAuthenticatedEvent());
      }
      if (timer.tick % 60 == 2 || timer.tick % 60 == 50) {
        connectivityResult = await (Connectivity().checkConnectivity());
      }
      text = (isConnected) ? "Обновление данных через ${60 - (timer.tick % 60)} секунд" : "Ожидание подключения";
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      decoration: BoxDecoration(
          color: isConnected ? Colors.green : Theme.of(context).colorScheme.errorContainer,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
      child: Center(child: Text(text)),
    );
  }
}
