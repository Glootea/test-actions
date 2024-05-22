import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/lesson__card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';
import 'package:queue/presentation/screens/main/page/today_screen/src/body/lesson_card/src/rounded_square_button.dart';

enum _ButtonState { add, remove, qrCode, none }

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  const LessonCard(this.lesson, {super.key});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  late final LessonCardCubit cubit;
  @override
  void initState() {
    cubit = LessonCardCubit(
      widget.lesson,
      context.read<DatabaseService>(),
      context.read<UserCubit>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<LessonCardCubit, LessonCardData>(builder: (context, data) {
        final bloc = context.read<LessonCardCubit>();
        final userQueueRecordStatus = data.queueRecordStatus;
        final buttonState = switch ((data.lesson.status, userQueueRecordStatus)) {
          (_, QueueRecordStatus.shouldBeUploaded) => _ButtonState.qrCode,
          (LessonStatus.active, null) => _ButtonState.add,
          (LessonStatus.active, QueueRecordStatus.uploaded) ||
          (LessonStatus.active, QueueRecordStatus.shouldBeUploaded) =>
            _ButtonState.remove,
          (_, _) => _ButtonState.none
        };
        return GestureDetector(
          onTap: () async => await AutoRouter.of(context).push(DetailedQueueRoute(cubit: cubit)),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 64,
                          child: Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Hero(
                              tag: cubit.hashCode,
                              child: Text(
                                data.lesson.name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (buttonState != _ButtonState.none)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: LessonCardButton(
                            icon: switch (buttonState) {
                              _ButtonState.qrCode => Icons.qr_code_outlined,
                              _ButtonState.add => Icons.add,
                              _ButtonState.remove => Icons.remove_outlined,
                              _ButtonState.none => throw UnimplementedError(),
                            },
                            onTap: () => switch (buttonState) {
                              _ButtonState.qrCode => bloc.showQrCode(),
                              _ButtonState.add => bloc.addQueueRecord(),
                              _ButtonState.remove => bloc.deleteQueueRecord(),
                              _ButtonState.none => throw UnimplementedError(),
                            },
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Hero(
                        tag: data.lesson.startTime.hashCode,
                        child: Text(
                          '${data.lesson.startTime.toDisplayTime} - ${data.lesson.endTime.toDisplayTime}', //TODO: add classroom to lesson class
                          // '16:20 - 17:50 в Г-321',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
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
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // Expanded(
                  //     //   child: Text(
                  //     //     data.message,
                  //     //     // 'Вы не находитесь в очереди',
                  //     //     textAlign: TextAlign.start,
                  //     //     style: Theme.of(context).textTheme.bodyLarge,
                  //     //     overflow: TextOverflow.ellipsis,
                  //     //   ),
                  //     // ),
                  //     Icon(
                  //       Icons.more_horiz_outlined,
                  //       color: Theme.of(context).textTheme.bodyMedium?.color,
                  //       size: 24,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
