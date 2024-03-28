import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/presentation/widgets/info_list/info_list.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String? headName;
  String? groupName;
  int id = 1;
  List<StudentEntity> students = [];
  List<LessonSettingEntity> lessons = [];
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Ошибка",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                content: Text(errorMessage!),
                actions: [
                  OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        "OK",
                      ))
                ],
              )));
    }

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_outlined),
            ),
          ),
          title: const Text("Создание группы"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Введите информацию", style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                TextFormField(
                  onChanged: (value) => headName = value,
                  decoration: const InputDecoration(hintText: 'Ваши фамилия и имя'),
                  validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
                  autovalidateMode: AutovalidateMode.always,
                  textCapitalization: TextCapitalization.words,
                ),
                const Gap(16),
                TextFormField(
                  onChanged: (value) => groupName = value,
                  decoration: const InputDecoration(hintText: 'Название группы'),
                  validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
                  autovalidateMode: AutovalidateMode.always,
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "Добавьте остальных студентов",
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 32),
                      child: Text("Админ"),
                    )
                  ],
                ),
                const Gap(16),
                InfoList<StudentEntity>(students),
                const Gap(16),
                Text("Добавьте занятия", style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                InfoList<LessonSettingEntity>(lessons),
                // const Gap(16),
                // Text("", style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                OutlinedButton(
                    onPressed: () {
                      if ((headName?.isEmpty ?? true) ||
                          (groupName?.isEmpty ?? true) ||
                          students.isEmpty ||
                          lessons.isEmpty) {
                        errorMessage = "Необходимо заполнить все поля, добавить хотя бы одного студента и занятие";
                        setState(() {});
                      } else {
                        context.read<QueueBloc>().add(RegisterGroupEvent(headName!, groupName!, lessons, students));
                      }
                    },
                    child: const Text(
                      "Сохранить и продолжить",
                      // style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    ))
              ],
            ),
          ),
        ));
  }
}
