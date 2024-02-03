import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class TelegramBotScreen extends StatelessWidget {
  const TelegramBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<QueueBloc>().add(FindUserEvent());
              // Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: const Hero(tag: "Telegram bot", child: Text("Telegram bot")),
      ),
      body: const Center(child: Text("Telegram Page")),
    );
  }
}
