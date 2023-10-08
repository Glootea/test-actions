import 'package:flutter/material.dart';

class QrButton extends StatelessWidget {
  const QrButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
        onPressed: () {},
        child: const Icon(Icons.qr_code_rounded, color: Colors.black));
  }
}
