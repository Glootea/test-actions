import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/new_local_database.dart';
import 'package:queue/presentation/common_src/imaged_background.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/screens/today_screen/src/circular_update_timer.dart';
import 'package:queue/presentation/screens/today_screen/src/lesson_list_view.dart';
import 'package:queue/presentation/screens/today_screen/today_screen_cubit.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayScreenCubit>();
    final KeyValueStorage storage = context.read<KeyValueStorage>();
    return LoadingContainer<TodayScreenCubit, TodayScreenState>(
        cubit: cubit,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: const Text("Занятия на сегодня"),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined))],
            centerTitle: true,
            leading: CircularUpdateTimer(
              durationInSeconds: 30,
              isUpdatingQueue: storage.get(StoredValues.isUpdatingQueue),
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
        )));
  }
}
