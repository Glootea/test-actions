import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/student.dart';

class SelectStudentTile extends StatelessWidget {
  final StudentEntity student;
  final Function() onTap;
  const SelectStudentTile({required this.student, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: GestureDetector(
            onTap: () => (student.isAdmin == false) ? onTap() : null,
            child: ColoredBox(
              color: Colors.transparent,
              child: Row(children: [
                Text(student.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary.withAlpha(student.isAdmin ? 160 : 255))),
                if (student.isAdmin) const Spacer(),
                if (student.isAdmin) const Icon(Icons.verified_user_outlined, size: 24),
                if (student.isAdmin) const Gap(16),
                if (student.isAdmin)
                  const Tooltip(
                      message: "Админы могут получить доступ только по прямой ссылке",
                      triggerMode: TooltipTriggerMode.tap,
                      child: Icon(Icons.info_outline, size: 24))
              ]),
            )));
  }
}
