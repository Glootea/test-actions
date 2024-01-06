import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class RecButton extends StatelessWidget {
  final LessonEntity lesson;
  const RecButton(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    if (lesson.userRec == null) {
      return OutlinedButton(
          onPressed: () => context.read<QueueBloc>().add(CreateRegEvent(lesson.name)),
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          child: Text('Записаться', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)));
    } else {
      return OutlinedButton(
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                showCloseIcon: true,
                content: Text(
                  "Спасибо за поддержание порядка!",
                  style: Theme.of(context).textTheme.bodyMedium,
                )));
            context.read<QueueBloc>().add(DeleteRegEvent(lesson.name));
          },
          child: Text(
            "Запись\nиспользована",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
          ));
    }
  }
}
