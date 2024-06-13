import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/go_to_tile.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';
import 'package:queue/presentation/common_src/screen_padding.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/app_bar/circular_update_timer.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/detailed_page/src/queue_record_listtile.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/lesson_card.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';

@RoutePage()
class DetailedQueueScreen extends StatelessWidget {
  const DetailedQueueScreen(this.cubit, {super.key});
  final LessonCardCubit cubit;

  @override
  Widget build(BuildContext context) {
    final useAttendance = context.select((GroupMetaInfoCubit cubit) => cubit.useAttendance);
    final admin = context.select((UserCubit cubit) => cubit.state?.isAdmin ?? false);
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<LessonCardCubit, LessonCardData>(
        builder: (context, data) {
          final storage = context.read<KeyValueStorage>();
          return SafeArea(
            child: Scaffold(
              body: ScreenPadding(
                child: ListView(
                  children: [
                    ScreenHeadline(
                      title: data.lesson.name,
                      heroTag: 'headline${data.lesson}',
                    ),
                    const Gap(32),
                    Builder(
                      builder: (context) {
                        final children = [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) => Row(
                                  children: [
                                    const Text('Обновление: '),
                                    Hero(
                                      tag: 'circularUpdateTimer',
                                      child: CircularUpdateTimer(
                                        durationInSeconds: 30,
                                        isUpdatingQueueRequest: storage.get(StoredValues.isUpdatingQueue),
                                        onTimeExpired: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: 'lessonButton${data.lesson}',
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ConfiguredLessonButton(cubit: cubit, data: data),
                                ),
                              ),
                            ],
                          ),
                          LessonMetadataAndAttendanceRow(useAttendance: useAttendance, cubit: cubit, data: data),
                        ];
                        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
                      },
                    ),
                    Hero(
                      tag: 'progressIndicator${data.lesson}',
                      flightShuttleBuilder: (
                        BuildContext _,
                        Animation<double> __,
                        HeroFlightDirection ___,
                        BuildContext fromHeroContext,
                        BuildContext ____,
                      ) =>
                          SingleChildScrollView(child: fromHeroContext.widget),
                      child: LabeledLinearProgressIndicator(
                        startValue: 0,
                        currentValue: 14,
                        endValue: 15,
                        message: data.message,
                      ),
                    ),
                    const Gap(16),
                    if (admin)
                      Column(
                        children: [
                          const Divider(),
                          GoToTile(
                            title: 'Перейти к изменению занятия',
                            route: SubjectAdminRoute(subjectID: data.lesson.subjectLocalID),
                            heroTag: 'SubjectPage${data.lesson}',
                          ),
                          const Gap(16),
                          GoToTile(
                              title: 'Перейти к изменению очереди',
                              route: QueueAdminRoute(subjectID: data.lesson.subjectLocalID)),
                          const Divider(),
                        ],
                      ),
                    const Gap(16),
                    Text('Очередь', style: Theme.of(context).textTheme.headlineMedium),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.queueData?.queueRecordList.length ?? 0,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          QueueRecordListtile(index, data.queueData!.queueRecordList[index]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
