import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/widgets/connectiom_status.dart';
import 'package:queue/presentation/widgets/lesson_widget.dart';
import 'package:queue/presentation/widgets/padding.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    super.key,
  });

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
            child: Column(
              children: [
                const MyPadding(),
                RepaintBoundary(
                  child: Row(
                    children: [
                      const ConnectionStatusWidget(),
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          child: const Icon(Icons.more_vert_outlined))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const MyPadding(),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 2),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("Пары с очередью сегодня",
                                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge))),
                      const MyPadding(),
                      (mainState.todayLessons.isEmpty)
                          ? Text(
                              "Пар с очередью нет",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: mainState.todayLessons.length,
                              itemBuilder: (context, index) =>
                                  LessonWidget((mainState as MainState).todayLessons[index]),
                              separatorBuilder: (context, index) => const MyPadding(),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
