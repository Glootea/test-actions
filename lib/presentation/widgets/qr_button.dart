import 'package:flutter/material.dart';

class QrButton extends StatelessWidget {
  const QrButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {}, child: const Icon(Icons.qr_code_rounded));
  }
}
