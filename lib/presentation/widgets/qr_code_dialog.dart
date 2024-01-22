import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/states.dart';

class QrCodeDialog extends StatelessWidget {
  const QrCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final data = (context.read<QueueBloc>().state as ShowQRCodeState).data;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: PrettyQrView(
        qrImage: QrImage(QrCode(14, QrErrorCorrectLevel.H)..addData(data)),
        decoration: const PrettyQrDecoration(shape: PrettyQrSmoothSymbol(roundFactor: 0)),
      ),
      actions: [
        TextButton(
          child: const Text("Закрыть", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
