import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/encryprion.dart';
import 'package:queue/logic/states.dart';

class QrButton extends StatelessWidget {
  final String lessonName;
  const QrButton(this.lessonName, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
        onPressed: () async {
          final bloc = context.read<QueueBloc>();
          final state = bloc.state as MainState;
          final rec = state.todayLessons
              .firstWhere((element) => element.name == lessonName)
              .userRec!;
          final dateTime = rec.time;
          String userName = rec.userName;
          String data = "&&&$lessonName&&&$userName&&&$dateTime";
          // print(
          //   Uri.https("localhost:8000", "/#upload", {"info": data}),
          // );
          String output = "https://queue-01-22.web.app/upload/" +
              Encryption.encryct(data).replaceAll('/', '%');

          print(output);

          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    content: PrettyQrView(
                      qrImage: QrImage(QrCode(
                        14,
                        QrErrorCorrectLevel.H,
                      )..addData(output)),
                      decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(roundFactor: 0)),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Закрыть",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.qr_code_rounded, color: Colors.black));
  }
}
