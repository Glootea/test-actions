import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/admin_settings_screen_template.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';

@RoutePage()
class QueueAdminPage extends StatelessWidget {
  const QueueAdminPage({required this.subjectID, super.key});

  final int subjectID;

  @override
  Widget build(BuildContext context) {
    return AdminSettingsScreenTemplate(
      onSubmit: () async {},
      title: 'Изменение очереди: $subjectID',
      headlineHeroTag: 'QueueAdminPage$subjectID',
      children: [Container()],
    );
  }
}
