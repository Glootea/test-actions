import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/sources/local_database/new_local_database.dart';

class CircularUpdateTimer extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback onTimeExpired;
  final Future<String?>? isUpdatingQueue;
  const CircularUpdateTimer(
      {super.key, required this.durationInSeconds, required this.onTimeExpired, this.isUpdatingQueue});

  @override
  State<CircularUpdateTimer> createState() => _CircularUpdateTimerState();
}

class _CircularUpdateTimerState extends State<CircularUpdateTimer> {
  late bool isUpdating = true;
  int timerValue = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    final future = widget.isUpdatingQueue;
    if (future == null) {
      createTimer();
    } else {
      future.then((value) {
        print(value);
        if (value == 'true') {
          createTimer();
        } else {
          resetTimer();
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void createTimer() {
    isUpdating = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.durationInSeconds - timerValue == 0) {
        widget.onTimeExpired();
      }
      setState(() => timerValue = (timerValue + 1) % widget.durationInSeconds);
    });
  }

  void resetTimer() {
    setState(() {
      isUpdating = false;
      timerValue = 0;
    });
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() {
              isUpdating ? resetTimer() : createTimer();
              context.read<KeyValueStorage>().set(StoredValues.isUpdatingQueue, isUpdating.toString());
            }),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: CircularProgressIndicator(
              value: isUpdating ? timerValue / widget.durationInSeconds : 1,
              color:
                  isUpdating ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.error,
            )));
  }
}
