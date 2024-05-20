import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/detailed_page/src/queue_record_listtile.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson__card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson_card_cubit.dart';

@RoutePage()
class DetailedQueueScreen extends StatelessWidget {
  final LessonCardCubit cubit;

  const DetailedQueueScreen(this.cubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<LessonCardCubit, LessonCardData?>(builder: (context, data) {
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
                      tag: cubit.hashCode,
                      child: Text(
                        data?.lesson.name ?? '',
                        style: Theme.of(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Text("Очередь", style: Theme.of(context).textTheme.headlineMedium),
                  const Gap(16),
                  ListView.separated(
                      shrinkWrap: true,
                      itemCount: data?.queueData?.queueRecordList.length ?? 0,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          QueueRecordListtile(index, data!.queueData!.queueRecordList[index]))
                ],
              ),
            ),
          ));
        }));
  }
}
