import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/states.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:queue/secret.dart';

class QrButton extends StatelessWidget {
  final String lessonName;
  const QrButton(this.lessonName, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
        onPressed: () async {
          final encrypter =
              enc.Encrypter(Salsa20(enc.Key.fromBase64(ENCRIPTION_KEY)));
          final bloc = context.read<QueueBloc>();
          final state = bloc.state as MainState;
          final rec = state.todayLessons
              .firstWhere((element) => element.tableName == lessonName)
              .userRec!;
          final dateTime = rec.time;
          String userName = rec.userName;
          String string = "&&&$lessonName&&&$userName&&&$dateTime";
          String output =
              encrypter.encrypt(string, iv: enc.IV.fromLength(8)).base64;
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    content: PrettyQrView(
                      qrImage: QrImage(QrCode(
                        8,
                        QrErrorCorrectLevel.L,
                      )..addData(output)),
                      decoration: const PrettyQrDecoration(),
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
