import 'package:flutter/material.dart';
import 'package:queue/models/lesson.dart';

class RecButton extends StatelessWidget {
  final Lesson lesson;
  const RecButton(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    if (lesson.userRec == null) {
      return OutlinedButton(onPressed: () {}, child: const Text('Записаться'));
    } else {
      return OutlinedButton(
          onPressed: () {}, child: const Text("Запись\nиспользована"));
    }
  }
}
