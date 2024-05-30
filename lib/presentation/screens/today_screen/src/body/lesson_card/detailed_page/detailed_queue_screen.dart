import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/presentation/screens/today_screen/src/app_bar/circular_update_timer.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/detailed_page/src/queue_record_listtile.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';

@RoutePage()
class DetailedQueueScreen extends StatelessWidget {
  final LessonCardCubit cubit;

  const DetailedQueueScreen(this.cubit, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool useAttendance = context.select((GroupMetaInfoCubit cubit) => cubit.useAttendance);
    final bool admin = context.select((UserCubit cubit) => cubit.state?.isAdmin ?? false);
    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<LessonCardCubit, LessonCardData>(builder: (context, data) {
          final KeyValueStorage storage = context.read<KeyValueStorage>();
          return SafeArea(
              child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  InkWell(
                    onTap: () => AutoRouter.of(context).maybePop(),
                    child: Hero(
                      tag: "headline${data.lesson}",
                      child: Text(
                        data.lesson.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Builder(
                    builder: (context) {
                      final children = [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Builder(
                            builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Обновление: "),
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
                            tag: "lessonButton${data.lesson}",
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ConfiguredLessonButton(cubit: cubit, data: data),
                            ),
                          )
                        ]),
                        LessonMetadataAndAttendanceRow(useAttendance: useAttendance, cubit: cubit, data: data),
                      ];
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
                    },
                  ),
                  Hero(
                    tag: "progressIndicator${data.lesson}",
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
                      currentValue: 1,
                      endValue: 15,
                      message: data.message,
                    ),
                  ),
                  const Gap(16),
                  Text("Очередь", style: Theme.of(context).textTheme.headlineMedium),
                  if (admin)
                    ListTile(
                      title: Text("Перейти к изменению очереди и занятия"),
                      trailing: Icon(Icons.chevron_right_outlined),
                    ),
                  const Gap(16),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.queueData?.queueRecordList.length ?? 0,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          QueueRecordListtile(index, data.queueData!.queueRecordList[index]))
                ],
              ),
            ),
          ));
        }));
  }
}
