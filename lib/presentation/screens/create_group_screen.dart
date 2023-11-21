import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/data/database/database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String? firstName;
  String? lastName;
  String? groupName;
  int id = 1;
  List<Student> students = [];
  List<Lesson> lessons = [];
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
                      child: Text(
                        "OK",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
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
                Text("Заполните поля",
                    style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                TextField(
                  onChanged: (value) => firstName = value,
                  decoration: const InputDecoration.collapsed(hintText: 'Имя'),
                ),
                const Gap(16),
                TextField(
                  onChanged: (value) => lastName = value,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Фамилия'),
                ),
                const Gap(16),
                TextField(
                  onChanged: (value) => groupName = value,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Название группы'),
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: students.length + 1,
                    itemBuilder: (context, count) {
                      if (count == 0) {
                        return InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: const Icon(
                              Icons.add_outlined,
                              color: Colors.white,
                            ),
                            title: Text("Добавить студента",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        );
                      } else {
                        return ListTile(
                          //TODO: create component with outer functions
                          leading: Text(count.toString()),
                          title: Row(children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: students[count - 1].name,
                                onChanged: (value) {},
                              ),
                            ),
                            const Gap(16),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete_outline))
                          ]),
                          trailing: Switch(
                              value: students[count - 1].isAdmin ?? false,
                              onChanged: (value) => setState(() {
                                    //  TODO: update in db
                                  })),
                        );
                      }
                    }),
                const Gap(16),
                Text("Добавьте занятия",
                    style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                Text(
                    "Войдите через Google аккаунт и предоставьте необходимые разрешения, чтобы завершить настройку",
                    style: Theme.of(context).textTheme.headlineSmall),
                const Gap(16),
                OutlinedButton(
                    onPressed: () {
                      if ((firstName?.isEmpty ?? true) ||
                          (lastName?.isEmpty ?? true) ||
                          (groupName?.isEmpty ?? true)) {
                        errorMessage = "Необходимо заполнить все поля";
                        setState(() {});
                      } else {
                        context.read<QueueBloc>().add(RegisterGroupEvent(
                            firstName, lastName, groupName, [], []));
                      }
                    },
                    child: Text(
                      "Войти через Google",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ))
              ],
            ),
          ),
        ));
  }
}
