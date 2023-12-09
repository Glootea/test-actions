import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/data/database/local_database.dart';
import 'package:drift/drift.dart' as drift;

class StudentInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final GlobalKey<AnimatedListState> _listKey;
  final List<Student> students;
  final int count;
  const StudentInfoTile(this.animation, this._listKey, this.students, this.count, {super.key});

  @override
  State<StudentInfoTile> createState() => _StudentInfoTileState();
}

class _StudentInfoTileState extends State<StudentInfoTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.students[widget.count]),
        sizeFactor: widget.animation,
        child: Column(
          children: [
            (widget.count != 0) ? const Divider() : Container(),
            ListTile(
              // Student field
              //TODO: create component with outer functions
              leading: Text((widget.count + 1).toString()),
              title: Row(children: [
                Expanded(
                    child: TextFormField(
                  focusNode: (widget.count == widget.students.length - 1 && widget.students[widget.count].name.isEmpty) ? (FocusNode()..requestFocus()) : null,
                  key: UniqueKey(),
                  initialValue: widget.students[widget.count].name,
                  onChanged: (value) {
                    widget.students[widget.count] = widget.students[widget.count].copyWith(name: value);
                  },
                  decoration: const InputDecoration(hintText: "Фамилия и имя студента"),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
                )),
                const Gap(16),
                IconButton(
                    onPressed: () {
                      _onDeleteButtonPressed(context, widget.count, widget._listKey);
                    },
                    icon: const Icon(Icons.delete_outline))
              ]),
              trailing: Switch(
                  value: widget.students[widget.count].isAdmin ?? false,
                  onChanged: (value) {
                    setState(() {
                      widget.students[widget.count] = widget.students[widget.count].copyWith(isAdmin: drift.Value(value));
                    });
                  }),
            ),
          ],
        ));
  }

  void _onDeleteButtonPressed(BuildContext context, int count, GlobalKey<AnimatedListState> listKey) {
    listKey.currentState?.removeItem(count, (count, a) => RemovedItemFromInfoList(a), duration: const Duration(milliseconds: 500));
    widget.students.removeAt(count);
    for (int i = count; i < widget.students.length; i++) {
      widget.students[i] = widget.students[i].copyWith(id: i + 1);
    }
  }
}

class RemovedItemFromInfoList extends StatelessWidget {
  final Animation<double> a;
  const RemovedItemFromInfoList(this.a, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: a.drive(CurveTween(curve: Curves.easeInOut)),
      child: ListTile(
        title: Align(
            child: Icon(
          Icons.delete_outline_outlined,
          color: Theme.of(context).colorScheme.error,
        )),
      ),
    );
  }
}
