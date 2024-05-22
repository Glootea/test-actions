import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/app_bar/circular_update_timer.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/detailed_page/src/queue_record_listtile.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson__card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';

@RoutePage()
class DetailedQueueScreen extends StatefulWidget {
  final LessonCardCubit cubit;

  const DetailedQueueScreen(this.cubit, {super.key});

  @override
  State<DetailedQueueScreen> createState() => _DetailedQueueScreenState();
}

class _DetailedQueueScreenState extends State<DetailedQueueScreen> {
  late Widget updateTimer;

  @override
  void initState() {
    final KeyValueStorage storage = context.read<KeyValueStorage>();
    updateTimer = CircularUpdateTimer(
      durationInSeconds: 30,
      isUpdatingQueueRequest: storage.get(StoredValues.isUpdatingQueue),
      onTimeExpired: () {},
      key: GlobalKey(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: widget.cubit,
        child: BlocBuilder<LessonCardCubit, LessonCardData>(builder: (context, data) {
          return SafeArea(
              child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => AutoRouter.of(context).maybePop(),
                    child: Hero(
                      tag: widget.cubit.hashCode,
                      child: Text(
                        data.lesson.name,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Builder(
                    builder: (context) {
                      final children = [
                        Hero(
                          tag: data.lesson.startTime.hashCode,
                          child: Text(
                            "${data.lesson.startTime.toDisplayTime} - ${data.lesson.endTime.toDisplayTime}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Row(children: [const Text("Обновление: "), updateTimer])
                      ];
                      return MediaQuery.sizeOf(context).aspectRatio > 1
                          ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children)
                          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
                    },
                  ),
                  Hero(
                    tag: data.queueData.hashCode,
                    child: LabeledLinearProgressIndicator(
                      startValue: 0,
                      currentValue: data.queueData?.userPosition,
                      endValue: data.queueData?.queueLength,
                      message: data.message,
                    ),
                  ),
                  const Gap(16),
                  Text("Очередь", style: Theme.of(context).textTheme.headlineMedium),
                  const Gap(16),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: data.queueData?.queueRecordList.length ?? 0,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) =>
                            QueueRecordListtile(index, data.queueData!.queueRecordList[index])),
                  )
                ],
              ),
            ),
          ));
        }));
  }
}
