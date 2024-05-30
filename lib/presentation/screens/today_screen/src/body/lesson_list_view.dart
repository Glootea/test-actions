import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/rounded_square_button.dart';
import 'package:queue/presentation/screens/today_screen/today_screen_cubit.dart';

class LessonListView extends StatefulWidget {
  const LessonListView({super.key});

  @override
  State<LessonListView> createState() => _LessonListViewState();
}

class _LessonListViewState extends State<LessonListView> {
  double getInitialOffset(int length) => length * cardHeight + length * 16 + 52 + 16;

  final cardHeight = 156.0;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodayScreenCubit, TodayScreenState, SeparatedLessons>(
        selector: (state) => state.separatedLessons,
        builder: (context, state) {
          Widget getHeadline(String text) => Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(text, style: Theme.of(context).textTheme.displayMedium, overflow: TextOverflow.ellipsis),);
          final children = <Widget>[
            if (state.passedLessons.isNotEmpty) ...[
              getHeadline('Прошедшие'),
              Column(children: state.passedLessons.map(LessonCard.new).toList()),
            ],
            if (state.activeLessons.isNotEmpty) ...[
              Row(children: [
                Expanded(child: getHeadline('Активные')),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: RoundedSquareButton(
                      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                      icon: Icons.qr_code_scanner_outlined,
                      onTap: () => context.router.push(const QrScannerRoute()),),
                ), // TODO: move to cubit
              ],),
              Column(children: state.activeLessons.map(LessonCard.new).toList()),
            ],
            if (state.futureLessons.isNotEmpty) ...[
              getHeadline('Предстоящие'),
              Column(children: state.futureLessons.map(LessonCard.new).toList()),
            ],
            SizedBox(height: getInitialOffset(state.passedLessons.length)),
          ];
          return state.isEmpty
              ? const _EmptyLessonListCard()
              : ListView.separated(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                  shrinkWrap: true,
                  controller: scrollController,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) => children[index],
                  itemCount: children.length,);
        },);
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Занятий нет',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),),);
  }
}
