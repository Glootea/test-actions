import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/go_to_tile.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';
import 'package:queue/presentation/common_src/screen_padding.dart';

@RoutePage()
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPadding(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: ScreenHeadline(
                title: 'Админ панель',
                heroTag: 'Админ панель',
              ),
            ),
            const Gap(16),
            ListView(
              shrinkWrap: true,
              children: [
                const GoToTile(title: 'Студенты', route: StudentAdminRoute(), heroTag: 'Студенты'),
                GoToTile(
                  title: 'Занятия',
                  route: ChooseSubjectRoute(
                    onTap: (subjectID) => AutoRouter.of(context).push(SubjectAdminRoute(subjectID: subjectID)),
                  ),
                ),
                GoToTile(
                  title: 'Модерация очереди',
                  route: ChooseSubjectRoute(
                    onTap: (subjectID) => AutoRouter.of(context).push(QueueAdminRoute(subjectID: subjectID)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
