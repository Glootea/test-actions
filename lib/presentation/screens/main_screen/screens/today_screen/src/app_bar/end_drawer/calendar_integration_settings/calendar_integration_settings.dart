import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';

@RoutePage()
class CalendarIntegrationSettingsScreen extends StatelessWidget {
  const CalendarIntegrationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ListView(
              children: const [
                ScreenHeadline(title: 'Интеграция с календарем', heroTag: 'Интеграция с календарем'),
              ],
            )));
  }
}
