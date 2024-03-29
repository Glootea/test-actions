import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  final List<String> routes = const ["Ученики", "Занятия", "Очереди", "Telegram bot"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () => context.read<QueueBloc>().add(NavigateToAdminSettingEvent(index)),
                child: ListTile(
                  title: Hero(
                    tag: routes[index],
                    child: Text(
                      routes[index],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ))),
      ),
    );
  }
}
