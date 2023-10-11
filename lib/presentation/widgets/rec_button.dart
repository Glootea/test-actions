import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/models/lesson.dart';

class RecButton extends StatelessWidget {
  final Lesson lesson;
  const RecButton(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    if (lesson.userRec == null) {
      return OutlinedButton(
          onPressed: () =>
              context.read<QueueBloc>().add(CreateRegEvent(lesson.tableName)),
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          child: Text('Записаться',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black)));
    } else {
      return OutlinedButton(
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                showCloseIcon: true,
                content: Text("Спасибо за поддержание порядка!")));
            context.read<QueueBloc>().add(DeleteRegEvent(lesson.tableName));
          },
          child: Text(
            "Запись\nиспользована",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ));
    }
  }
}
