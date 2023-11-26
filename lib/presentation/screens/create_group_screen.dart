import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/data/database/local_database.dart';
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
                StudentInfoList(students),
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

class StudentInfoList extends StatelessWidget {
  StudentInfoList(
    this.students, {
    super.key,
  });

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: students.length + 1,
        itemBuilder: (context, count, animation) {
          if (count == students.length) {
            return AddNewStudentTile(animation, _listKey, students);
          } else {
            return StudentInfoTile(animation, _listKey, students, count);
          }
        });
  }
}

class AddNewStudentTile extends StatelessWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<Student> students;
  const AddNewStudentTile(this.animation, this._listKey, this.students,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInOut)),
      child: InkWell(
        onTap: () {
          _onAddButtonPressed(_listKey);
        },
        child: ListTile(
          // Create new student field
          leading: const Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
          title: Text("Добавить студента",
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }

  void _onAddButtonPressed(GlobalKey<AnimatedListState> listKey) {
    listKey.currentState?.insertItem(
      students.length,
      duration: const Duration(milliseconds: 500),
    );
    students.add(Student(id: students.length + 1, name: '', isAdmin: false));
  }
}

class StudentInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<Student> students;
  final int count;
  const StudentInfoTile(
      this.animation, this._listKey, this.students, this.count,
      {super.key});

  @override
  State<StudentInfoTile> createState() => _StudentInfoTileState();
}

class _StudentInfoTileState extends State<StudentInfoTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.students[widget.count]),
        sizeFactor: widget.animation,
        child: ListTile(
          // Student field
          //TODO: create component with outer functions
          leading: Text((widget.count + 1).toString()),
          title: Row(children: [
            Expanded(
                child: TextFormField(
              focusNode: (widget.count == widget.students.length - 1 &&
                      widget.students[widget.count].name.isEmpty)
                  ? (FocusNode()..requestFocus())
                  : null,
              key: UniqueKey(),
              initialValue: widget.students[widget.count].name,
              onChanged: (value) {
                widget.students[widget.count] =
                    widget.students[widget.count].copyWith(name: value);
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (value) =>
                  value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
            )),
            const Gap(16),
            IconButton(
                onPressed: () {
                  _onDeleteButtonPressed(
                      context, widget.count, widget._listKey);
                },
                icon: const Icon(Icons.delete_outline))
          ]),
          trailing: Switch(
              value: widget.students[widget.count].isAdmin ?? false,
              onChanged: (value) {
                setState(() {
                  widget.students[widget.count] = widget.students[widget.count]
                      .copyWith(isAdmin: drift.Value(value));
                });
              }),
        ));
  }

  void _onDeleteButtonPressed(
      BuildContext context, int count, GlobalKey<AnimatedListState> listKey) {
    listKey.currentState?.removeItem(
        count,
        (count, a) => SizeTransition(
              sizeFactor: a.drive(CurveTween(curve: Curves.easeInOut)),
              child: ListTile(
                title: Align(
                    child: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).colorScheme.error,
                )),
              ),
            ),
        duration: const Duration(milliseconds: 500));
    widget.students.removeAt(count);
    for (int i = count; i < widget.students.length; i++) {
      widget.students[i] = widget.students[i].copyWith(id: i + 1);
    }
  }
}
