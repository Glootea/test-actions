import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/navigation.dart';

@RoutePage()
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final children = <(String, PageRouteInfo<void>)>[
      ('Студенты', const StudentAdminRoute()),
      // ('Занятия',  SubjectAdminRoute()),
      // ('Модерация очереди',  QueueAdminRoute()),
      ('Телеграм бот', const TelegramBotAdminRoute()),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Админ панель',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(16),
            ListView.separated(
              shrinkWrap: true,
              itemCount: children.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  children[index].$1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () async => AutoRouter.of(context).push(children[index].$2),
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
