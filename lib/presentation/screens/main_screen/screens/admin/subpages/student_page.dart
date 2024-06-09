import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/admin_settings_screen_template.dart';

@RoutePage()
class StudentAdminPage extends StatelessWidget {
  const StudentAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminSettingsScreenTemplate(
      onSubmit: (context) async {},
      title: 'Студенты',
      headlineHeroTag: 'Студенты',
      children: [Container()],
    );
  }
}
