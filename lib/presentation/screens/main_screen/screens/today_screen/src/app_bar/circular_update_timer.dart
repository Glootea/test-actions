import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';

final circularUpdateTimerKey = GlobalKey();

class CircularUpdateTimer extends StatefulWidget {
  const CircularUpdateTimer(
      {required this.durationInSeconds, required this.onTimeExpired, super.key, this.isUpdatingQueueRequest,});
  final int durationInSeconds;
  final VoidCallback onTimeExpired;
  final Future<String?>? isUpdatingQueueRequest;

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
    final future = widget.isUpdatingQueueRequest;
    if (future == null) {
      createTimer();
    } else {
      future.then((value) {
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
      if (mounted) {
        setState(() => timerValue = (timerValue + 1) % widget.durationInSeconds);
      }
    });
  }

  void resetTimer() {
    if (mounted) {
      setState(() {
        isUpdating = false;
        timerValue = 0;
      });
    }

    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
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
              ),),),
    );
  }
}
