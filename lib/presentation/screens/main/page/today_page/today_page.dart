import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/presentation/common_src/imaged_background.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/circular_update_timer.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_list_view.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/today_lessons_end_drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final KeyValueStorage storage = context.read<KeyValueStorage>();
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 16,
            title: const Text("Занятия на сегодня"),
            actions: [
              IconButton(
                  onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                  icon: const Icon(Icons.settings_outlined))
            ],
            centerTitle: true,
            leading: CircularUpdateTimer(
              durationInSeconds: 30,
              isUpdatingQueueRequest: storage.get(StoredValues.isUpdatingQueue),
              onTimeExpired: () {},
            ),
          ),
          body: const Stack(
            fit: StackFit.expand,
            children: [
              ImagedBackground(),
              LessonListView(),
            ],
          ),
          endDrawer: const TodayLessonsEndDrawer()),
    );
  }
}
