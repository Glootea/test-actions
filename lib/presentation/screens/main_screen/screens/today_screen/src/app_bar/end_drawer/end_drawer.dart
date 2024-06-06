import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/defined_text.dart';
import 'package:queue/presentation/common_src/go_to_tile.dart';

class TodayLessonsEndDrawer extends StatelessWidget {
  const TodayLessonsEndDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final children = [
      const Padding(padding: EdgeInsets.only(left: 4, bottom: 8), child: H2('Настройки')),
      const GoToTile(title: 'Настройки темы', heroTag: 'Настройки темы', route: ThemeSettingsRoute()),
      const GoToTile(
        title: 'Интеграция с календарем',
        heroTag: 'Интеграция с календарем',
        route: CalendarIntegrationSettingsRoute(),
      ),
      const Divider(),
      OutlinedButton(
        onPressed: () => context.read<UserCubit>().login(name: 'Sasha', isAdmin: false, rowNumber: 1),
        child: const Text('Войти'),
      ),
      OutlinedButton(
        onPressed: () => context.read<UserCubit>().login(name: 'Sasha', isAdmin: true, rowNumber: 1),
        child: const Text('Войти админ'),
      ),
      OutlinedButton(
        onPressed: () {
          AutoRouter.of(context).navigate(const WelcomeRoute());
          context.read<UserCubit>().logout().then((value) => print(context.read<UserCubit>().state));
        },
        child: const Text('Выйти'),
      ),
    ];
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(itemCount: children.length, itemBuilder: (context, index) => children[index]),
        ),
      ),
    );
  }
}
