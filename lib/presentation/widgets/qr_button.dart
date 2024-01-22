import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class QrButton extends StatelessWidget {
  final String lessonName;
  const QrButton(this.lessonName, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
        onPressed: () async {
          final time = DateTime.now();
          final bloc = context.read<QueueBloc>();
          bloc.add(ShowQRCodeEvent(lessonName, time));
          // final state = bloc.state as MainState;
          // final rec = state.todayLessons.firstWhere((element) => element.name == lessonName).userRec!;
          // final dateTime = rec.time.toRecTime;
          // String userName = rec.userName;
          // String data = "&&&$lessonName&&&$userName&&&$dateTime";
          // String output = "https://queue-01-22.web.app/upload/${Encryption.encryct(data).replaceAll('/', '%')}";
          // await showDialog(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //           backgroundColor: Colors.white,
          //           content: PrettyQrView(
          //             qrImage: QrImage(QrCode(14, QrErrorCorrectLevel.H)..addData(output)),
          //             decoration: const PrettyQrDecoration(shape: PrettyQrSmoothSymbol(roundFactor: 0)),
          //           ),
          //           actions: [
          //             TextButton(
          //               child: const Text("Закрыть", style: TextStyle(color: Colors.black)),
          //               onPressed: () => Navigator.of(context).pop(),
          //             ),
          //           ],
          //         ));
        },
        child: Icon(Icons.qr_code_rounded, color: Theme.of(context).colorScheme.onPrimaryContainer));
  }
}
