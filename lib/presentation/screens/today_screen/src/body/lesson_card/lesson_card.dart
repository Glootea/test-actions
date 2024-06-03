import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/extension.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_data/lesson_card_data.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/labeled_linear_progress_indicator/labeled_linear_progress_indicator.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/qr_code_dialog/qr_code_dialog.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/src/rounded_square_button.dart';

enum ButtonState { add, remove, qrCode, none }

class LessonCard extends StatefulWidget {
  const LessonCard(this.lesson, {super.key});
  final Lesson lesson;

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
    final useAttendance = context.select((GroupMetaInfoCubit cubit) => cubit.useAttendance);
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<LessonCardCubit, LessonCardData>(
        builder: (context, data) {
          return GestureDetector(
            onTap: () async => AutoRouter.of(context).push(DetailedQueueRoute(cubit: cubit)),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 64,
                            child: Hero(
                              tag: 'headline${widget.lesson}',
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
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
                    Hero(
                      flightShuttleBuilder: (
                        BuildContext _,
                        Animation<double> __,
                        HeroFlightDirection ___,
                        BuildContext fromHeroContext,
                        BuildContext ____,
                      ) =>
                          SingleChildScrollView(child: fromHeroContext.widget),
                      tag: 'progressIndicator${data.lesson}',
                      // child: LabeledLinearProgressIndicator(
                      //   startValue: 0,
                      //   currentValue: data.queueData?.userPosition,
                      //   endValue: data.queueData?.queueLength,
                      //   message: data.message,
                      // ),
                      child: LabeledLinearProgressIndicator(
                        startValue: 0,
                        currentValue: 5,
                        endValue: 15,
                        message: data.message,
                      ),
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

//TODO: move to file
class LessonMetadataAndAttendanceRow extends StatelessWidget {
  const LessonMetadataAndAttendanceRow({
    required this.useAttendance,
    required this.cubit,
    required this.data,
    super.key,
  });

  final bool useAttendance;
  final LessonCardCubit cubit;
  final LessonCardData data;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'time${data.lesson}',
      child: Material(
        type: MaterialType.transparency,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Checkbox.width + 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  '${data.lesson.startTime.toDisplayTime} - ${data.lesson.endTime.toDisplayTime}', //TODO: add classroom to lesson class
                  // '16:20 - 17:50 в Г-321',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.visible,
                ),
              ),
              if (useAttendance)
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(4, 0),
                    child: Builder(
                      builder: (context) => Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Я на паре: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Checkbox(value: data.attended, onChanged: (value) => cubit.toggleAttended()),
                        ],
                      ),
                    ),
                  ),
                ),

              // TODO: implement custom checkbox to show error || loading
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: move to file
class ConfiguredLessonButton extends StatelessWidget {
  const ConfiguredLessonButton({
    required this.data,
    required this.cubit,
    super.key,
  });

  final LessonCardCubit cubit;
  final LessonCardData data;

  @override
  Widget build(BuildContext context) {
    if (data.buttonState == ButtonState.none) {
      return const SizedBox.shrink();
    }
    return RoundedSquareButton(
      icon: switch (data.buttonState) {
        ButtonState.qrCode => Icons.qr_code_outlined,
        ButtonState.add => Icons.add,
        ButtonState.remove => Icons.remove_outlined,
        ButtonState.none => throw UnimplementedError(),
      },
      onTap: () async => switch (data.buttonState) {
        ButtonState.qrCode =>
          await showDialog(context: context, builder: (context) => QrCodeDialog(data.queueData!.userRecord!)),
        ButtonState.add => cubit.addQueueRecord(),
        ButtonState.remove => cubit.deleteQueueRecord(),
        ButtonState.none => throw UnimplementedError(),
      },
    );
  }
}
