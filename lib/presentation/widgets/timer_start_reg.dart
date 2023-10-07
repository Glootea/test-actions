import 'dart:async';

import 'package:flutter/material.dart';

class TimerStartReg extends StatefulWidget {
  final TimeOfDay target;
  const TimerStartReg(this.target, {super.key});

  @override
  State<TimerStartReg> createState() => _TimerStartRegState();
}

class _TimerStartRegState extends State<TimerStartReg>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  DateTime get now => DateTime.now();
  Duration get diff => now
      .copyWith(
          hour: widget.target.hour, minute: widget.target.minute, second: 0)
      .difference(now);
  String time = '';
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int minutes = diff.inMinutes.abs();
      int seconds = diff < Duration.zero
          ? 60 - (diff.inSeconds % 60)
          : diff.inSeconds % 60;
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
