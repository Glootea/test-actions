import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class InviteScreen extends StatefulWidget {
  final String link;
  const InviteScreen(this.link, {super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  void initState() {
    context.read<QueueBloc>().add(InviteEvent(widget.link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueBloc, QueueState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          InviteState inviteState = state as InviteState;
          return Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Добро пожаловать в приложение для ведения очередей",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Вы были приглашены старостой группы ${inviteState.groupName} ${inviteState.headName}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Ваше имя - ${inviteState.userName}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Если информация верна, нажмите на кнопку для продолжения",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              OutlinedButton(
                  onPressed: () {
                    context.read<QueueBloc>().add(RegisterUserEvent(inviteState));
                  },
                  child: Text(
                    "Верно",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ],
          ));
        });
  }
}
