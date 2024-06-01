import 'package:flutter/material.dart';

class ToggleRow extends StatelessWidget {
  const ToggleRow({required this.text, required this.onChanged, required this.initialValue, super.key});

  final String text;
  final bool initialValue;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Switch(
          value: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
