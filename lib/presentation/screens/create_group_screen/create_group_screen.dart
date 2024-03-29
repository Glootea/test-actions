import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/presentation/common_src/dialog_factory.dart';
import 'package:queue/presentation/common_src/info_list_generic/info_list_generic.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String? groupLeader;
  String? groupName;
  int id = 1;
  List<StudentEntity> students = [];
  List<LessonEntity> lessons = [];
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      DialogFactory.showErrorDialog(context, errorMessage!);
    }

    final nameTextField = TextFormField(
      onChanged: (value) => groupLeader = value,
      decoration: const InputDecoration(hintText: 'Ваши фамилия и имя'),
      validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
      autovalidateMode: AutovalidateMode.always,
      textCapitalization: TextCapitalization.words,
    );
    final groupTextField = TextFormField(
      onChanged: (value) => groupName = value,
      decoration: const InputDecoration(hintText: 'Название группы'),
      validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
      autovalidateMode: AutovalidateMode.always,
    );

    final addStudentsTitle = Row(
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
    );

    final submitButton = OutlinedButton(
        onPressed: () {
          if ((groupLeader?.isEmpty ?? true) || (groupName?.isEmpty ?? true) || students.isEmpty || lessons.isEmpty) {
            errorMessage = "Необходимо заполнить все поля, добавить хотя бы одного студента и занятие";
            setState(() {});
          } else {
            context.read<QueueBloc>().add(RegisterGroupEvent(groupLeader!, groupName!, lessons, students));
          }
        },
        child: const Text(
          "Сохранить и продолжить",
          // style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
        ));

    final content = [
      Text("Введите информацию", style: Theme.of(context).textTheme.headlineSmall),
      const Gap(16),
      nameTextField,
      const Gap(16),
      groupTextField,
      const Gap(16),
      addStudentsTitle,
      const Gap(16),
      InfoList<StudentEntity>(students),
      const Gap(16),
      Text("Добавьте занятия", style: Theme.of(context).textTheme.headlineSmall),
      const Gap(16),
      InfoList<LessonEntity>(lessons),
      // const Gap(16),
      // Text("", style: Theme.of(context).textTheme.headlineSmall),
      const Gap(16),
      submitButton
    ];

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
        body: ListView.builder(
          itemCount: content.length,
          itemBuilder: (context, index) => content[index],
          // child: Padding(
          //   padding: const EdgeInsets.all(32),
          //   child: content,
          // ),
        ));
  }
}
