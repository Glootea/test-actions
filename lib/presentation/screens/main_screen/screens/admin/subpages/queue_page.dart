import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/admin_settings_screen_template.dart';

@RoutePage()
class QueueAdminPage extends StatelessWidget {
  const QueueAdminPage({required this.subjectID, super.key});

  final int subjectID;

  @override
  Widget build(BuildContext context) {
    return AdminSettingsScreenTemplate(
      onSubmit: (context) async {},
      title: 'Изменение очереди: $subjectID',
      headlineHeroTag: 'QueueAdminPage$subjectID',
      children: [Container()],
    );
  }
}
