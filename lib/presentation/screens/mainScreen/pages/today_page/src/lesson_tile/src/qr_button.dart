import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class showQrButton extends StatelessWidget {
  final String lessonName;
  final DateTime time;
  const showQrButton(this.lessonName, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: fix fail to reopen qr code
    return OutlinedButton(
        // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
        onPressed: () async {
          final bloc = context.read<QueueBloc>();
          bloc.add(ShowQRCodeEvent(lessonName, time));
        },
        child: Icon(Icons.qr_code_rounded, color: Theme.of(context).colorScheme.onPrimaryContainer));
  }
}
