import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/presentation/common_src/imaged_background.dart';
import 'package:queue/presentation/screens/today_screen/src/app_bar/circular_update_timer.dart';
import 'package:queue/presentation/screens/today_screen/src/today_lessons_end_drawer.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_list_view.dart';
import 'package:queue/presentation/screens/today_screen/today_screen_cubit.dart';

@RoutePage()
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = context.read<KeyValueStorage>();
    return BlocProvider(
      create: (context) => TodayScreenCubit(
        databaseService: context.read<DatabaseService>(),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 16,
            title: const Text('Занятия на сегодня'),
            actions: [
              Builder(
                builder: (innerContext) => IconButton(
                  onPressed: () => Scaffold.of(innerContext).openEndDrawer(),
                  icon: const Icon(Icons.settings_outlined),
                ),
              ),
            ],
            centerTitle: true,
            leading: Hero(
              tag: 'circularUpdateTimer',
              child: CircularUpdateTimer(
                durationInSeconds: 30,
                isUpdatingQueueRequest: storage.get(StoredValues.isUpdatingQueue),
                onTimeExpired: () {},
              ),
            ),
          ),
          body: const Stack(
            fit: StackFit.expand,
            children: [
              ImagedBackground(),
              LessonListView(),
            ],
          ),
          endDrawer: const TodayLessonsEndDrawer(),
        ),
      ),
    );
  }
}
