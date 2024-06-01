import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/admin/admin_settings_screen_template.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';

@RoutePage()
class QueueAdminPage extends StatelessWidget {
  const QueueAdminPage({required this.data, super.key});

  final LessonCardData data;

  @override
  Widget build(BuildContext context) {
    return AdminSettingsScreenTemplate(
      onSubmit: () async {},
      title: 'Изменение очереди: ${data.lesson.name}',
      headlineHeroTag: 'QueueAdminPage${data.lesson}',
      children: [Container()],
    );
  }
}
