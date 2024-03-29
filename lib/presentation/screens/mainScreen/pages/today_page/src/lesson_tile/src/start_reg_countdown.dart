import 'dart:async';

import 'package:flutter/material.dart';

class StartRecCountDown extends StatefulWidget {
  final TimeOfDay target;
  const StartRecCountDown(this.target, {super.key});

  @override
  State<StartRecCountDown> createState() => _StartRecCountDownState();
}

class _StartRecCountDownState extends State<StartRecCountDown> {
  late Timer timer;
  DateTime get now => DateTime.now();
  Duration get diff =>
      now.copyWith(hour: widget.target.hour, minute: widget.target.minute, second: 0).difference(now) -
      const Duration(minutes: 10);
  String time = '     ';
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int minutes = diff.inMinutes.abs();
      int seconds = diff < Duration.zero ? 60 - (diff.inSeconds % 60) : diff.inSeconds % 60;
      setState(() {
        time = "$minutes:${seconds < 10 ? '0$seconds' : seconds}";
      });
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
    return Text("До начала записи осталось: $time");
  }
}
