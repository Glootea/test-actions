import 'package:flutter/material.dart';

class LessonKoefSlider extends StatelessWidget {
  const LessonKoefSlider({required this.initialValue, required this.onChanged, super.key});

  final double initialValue;
  final void Function(double) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(value: initialValue, onChanged: onChanged),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Использовать только время',
                overflow: TextOverflow.visible,
              ),
            ),
            Text(
              'Поддерживать равенство сданных работ',
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ],
    );
  }
}
