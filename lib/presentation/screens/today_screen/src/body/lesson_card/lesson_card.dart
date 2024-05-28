import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/queue_record.dart';
import 'package:queue/extension.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson__card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/rounded_square_button.dart';

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
    final bool useAttendance = context.select((GroupMetaInfoCubit cubit) => cubit.useAttendance);
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<LessonCardCubit, LessonCardData>(builder: (context, data) {
        final userQueueRecordStatus = data.queueRecordStatus;
        final buttonState = switch ((data.lesson.status, userQueueRecordStatus)) {
          (_, UploadStatus.shouldBeUploaded) => _ButtonState.qrCode,
          (LessonStatus.active, null) => _ButtonState.add,
          (LessonStatus.active, UploadStatus.uploaded) ||
          (LessonStatus.active, UploadStatus.shouldBeUploaded) =>
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
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
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
                                tag: "headline${widget.lesson}",
                                child: Text(
                                  data.lesson.name,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400),
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
                                _ButtonState.qrCode => cubit.showQrCode(),
                                _ButtonState.add => cubit.addQueueRecord(),
                                _ButtonState.remove => cubit.deleteQueueRecord(),
                                _ButtonState.none => throw UnimplementedError(),
                              },
                            ),
                          ),
                      ],
                    ),
                    Hero(
                        tag: "time${data.lesson}",
                        child: Material(
                          color: Colors.transparent,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              '${data.lesson.startTime.toDisplayTime} - ${data.lesson.endTime.toDisplayTime}', //TODO: add classroom to lesson class
                              // '16:20 - 17:50 в Г-321',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            if (useAttendance) const Spacer(),
                            if (useAttendance) Text("Я на паре: ", style: Theme.of(context).textTheme.bodyMedium),
                            if (useAttendance)
                              Checkbox(value: data.attended, onChanged: (value) => cubit.toggleAttended()),
                          ]),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
