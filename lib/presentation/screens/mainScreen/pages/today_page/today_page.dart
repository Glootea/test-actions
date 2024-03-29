import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/connection_status_button.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/lesson_tile.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueBloc, QueueState>(
        bloc: context.read<QueueBloc>(),
        buildWhen: (previous, current) => previous != current,
        builder: (context, mainState) {
          mainState = mainState as MainState;
          return Padding(
            padding: MediaQuery.of(context).size.width > 600
                ? const EdgeInsets.symmetric(horizontal: 64.0)
                : const EdgeInsets.symmetric(horizontal: 16.0),
            child: RefreshIndicator(
              onRefresh: () => Future.delayed(
                  const Duration(seconds: 1), () => context.read<QueueBloc>()..add(UserAuthenticatedEvent())),
              child: Stack(children: [
                ListView(physics: const AlwaysScrollableScrollPhysics()),
                Column(
                  children: [
                    const Gap(16),
                    RepaintBoundary(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ConnectionStatusButton(),
                          OutlinedButton(
                              onPressed: () => Scaffold.of(context).openEndDrawer(),
                              child: const Icon(Icons.more_vert_outlined))
                        ],
                      ),
                    ),
                    const Gap(16),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Пары с очередью сегодня",
                                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge))),
                    const Gap(16),
                    (mainState.todayLessons.isEmpty)
                        ? Text(
                            "Пар с очередью нет",
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        : Expanded(
                            child: ListView.separated(
                              itemCount: mainState.todayLessons.length,
                              itemBuilder: (context, index) => LessonTile((mainState as MainState).todayLessons[index]),
                              separatorBuilder: (context, index) => const Gap(16),
                            ),
                          ),
                  ],
                ),
              ]),
            ),
          );
        });
  }
}
