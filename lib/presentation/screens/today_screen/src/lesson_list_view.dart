import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/entities/src/new_lesson.dart';
import 'package:queue/presentation/screens/today_screen/src/lesson_card.dart';
import 'package:queue/presentation/screens/today_screen/today_screen_cubit.dart';

class LessonListView extends StatelessWidget {
  const LessonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodayScreenCubit, TodayScreenState, List<Lesson>>(
        selector: (state) => state.newLessonList,
        builder: (context, lessons) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: lessons.isEmpty
                  ? const _EmptyLessonListCard()
                  : ListView.builder(
                      itemCount: lessons.length,
                      itemBuilder: (context, index) => LessonCard(lessons[index]),
                    ));
        });
  }
}

class _EmptyLessonListCard extends StatelessWidget {
  const _EmptyLessonListCard();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Занятий нет",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            )));
  }
}
