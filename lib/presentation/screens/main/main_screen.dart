import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/screens/main/main_screen_cubit.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/circular_update_timer.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/lesson_card.dart';
import 'package:queue/presentation/screens/main/page/today_page/src/lesson_card/src/rounded_square_button.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget getHeadline(String text) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(text, style: Theme.of(context).textTheme.displayMedium),
      );
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

  final cardHeight = 156.0;
  double getInitialOffset(int length) => length * cardHeight + length * 16 + 52 + 16;
  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();
    final databaseService = context.read<DatabaseService>();
    final cubit = TodayScreenCubit(
      databaseService: databaseService,
      userCubit: userCubit,
    );
    final KeyValueStorage storage = context.read<KeyValueStorage>();
    return BlocProvider.value(
        value: cubit,
        child: BlocListener<TodayScreenCubit, TodayScreenState>(
          listener: (context, state) {},
          child: LoadingContainer<TodayScreenCubit, TodayScreenState>(
            cubit: cubit,
            child: BlocSelector<TodayScreenCubit, TodayScreenState, List<Lesson>>(
                selector: (state) => state.lessonList,
                builder: (context, state) {
                  final pastLessons = state.where((lesson) => lesson.state == LessonState.inPast);
                  final activeLessons =
                      state.where((lesson) => lesson.state == LessonState.active || lesson.state == LessonState.soon);
                  final afterLessons = state.where((lesson) => lesson.state == LessonState.inFuture);
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                    await scrollController.animateTo(getInitialOffset(pastLessons.length),
                        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  });

                  final children = <Widget>[
                    if (pastLessons.isNotEmpty) ...[
                      getHeadline("Прошедшие"),
                      Column(children: pastLessons.map((lesson) => LessonCard(lesson)).toList())
                    ],
                    if (activeLessons.isNotEmpty) ...[
                      Row(children: [
                        getHeadline("Активные"),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: LessonCardButton(
                              icon: Icons.qr_code_scanner_outlined,
                              onTap: () => context.router.push(const QrScannerRoute())),
                        ) // TODO: move to cubit
                      ]),
                      Column(children: activeLessons.map((lesson) => LessonCard(lesson)).toList())
                    ],
                    if (afterLessons.isNotEmpty) ...[
                      getHeadline("Предстоящие"),
                      Column(children: afterLessons.map((lesson) => LessonCard(lesson)).toList())
                    ],
                    SizedBox(height: getInitialOffset(pastLessons.length))
                  ];
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 16,
                      title: const Text("Занятия на сегодня"),
                      actions: [
                        Builder(
                          builder: (context) => IconButton(
                              onPressed: () => Scaffold.of(context).openEndDrawer(),
                              icon: const Icon(Icons.settings_outlined)),
                        )
                      ],
                      centerTitle: true,
                      leading: CircularUpdateTimer(
                        durationInSeconds: 30,
                        isUpdatingQueueRequest: storage.get(StoredValues.isUpdatingQueue),
                        onTimeExpired: () {},
                      ),
                    ),
                    body: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                        shrinkWrap: true,
                        controller: scrollController,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: ((context, index) => children[index]),
                        itemCount: children.length),
                  );
                }),
            // );
          ),
        ));
  }
}
