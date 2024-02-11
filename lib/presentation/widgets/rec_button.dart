import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class RecButton extends StatelessWidget {
  final LessonEntity lesson;
  const RecButton(this.lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    if (lesson.userRec == null) {
      return OutlinedButton(
          onPressed: () => context.read<QueueBloc>().add(CreateRegEvent(lesson.name)),
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          child: Text('Записаться', style: Theme.of(context).textTheme.bodyMedium));
    } else {
      return OutlinedButton(
          // style: OutlinedButton.styleFrom(backgroundColor: Colors.white70),
          onPressed: () async {
            final scaffoldMessanger = ScaffoldMessenger.of(context);
            final theme = Theme.of(context);
            final bloc = context.read<QueueBloc>();
            int newWorkCount = 0;
            if (lesson.useWorkCount) {
              int workCount = lesson.userRec?.workCount ?? 0;
              int tempWorkCount = 1;
              newWorkCount = await showDialog(
                context: context,
                builder: (_) => PopScope(
                  canPop: false,
                  child: StatefulBuilder(
                    builder: (context, localSetState) => AlertDialog(
                      content: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const Text("На этой паре вы сдали:"),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SizedBox(
                              width: 24,
                              child: TextFormField(
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: TextEditingController(text: tempWorkCount.toString())
                                  ..selection = TextSelection.collapsed(offset: tempWorkCount.toString().length),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                onChanged: (value) =>
                                    value.isNotEmpty ? localSetState(() => tempWorkCount = int.parse(value)) : null,
                              ),
                            ),
                            const Text("   работ")
                          ]),
                          const Gap(16),
                          Text("Всего вы сдали: ${workCount + tempWorkCount} работ"),
                          const Gap(16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(onPressed: () => Navigator.pop(context, 0), child: const Text("Отмена")),
                              const Gap(16),
                              OutlinedButton(
                                  onPressed: () => Navigator.pop(context, workCount + tempWorkCount),
                                  child: const Text("OK"))
                            ],
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              );
              if (newWorkCount == 0) return;
            }
            scaffoldMessanger.showSnackBar(SnackBar(
                showCloseIcon: true,
                content: Text(
                  "Спасибо за поддержание порядка!",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
                )));
            bloc.add(DeleteRegEvent(lesson.name, workCount: lesson.useWorkCount ? newWorkCount : null));
          },
          child: Text(
            "Запись\nиспользована",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ));
    }
  }
}
