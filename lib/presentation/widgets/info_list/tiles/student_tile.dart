import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/src/student.dart';

class StudentInfoTile extends StatefulWidget {
  final Animation<double> animation;
  final List<StudentEntity> students;
  final int count;
  final Function(double) onDeleteButtonPressed;
  const StudentInfoTile(this.animation, this.students, this.count, this.onDeleteButtonPressed, {super.key});

  @override
  State<StudentInfoTile> createState() => _StudentInfoTileState();
}

class _StudentInfoTileState extends State<StudentInfoTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        key: ValueKey(widget.students[widget.count]),
        sizeFactor: CurvedAnimation(
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
          parent: widget.animation,
        ),
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
                  focusNode: (widget.count == widget.students.length - 1 && widget.students[widget.count].name.isEmpty)
                      ? (FocusNode()..requestFocus())
                      : null,
                  key: UniqueKey(),
                  initialValue: widget.students[widget.count].name,
                  onChanged: (value) {
                    widget.students[widget.count] = widget.students[widget.count].copyWith(name: value);
                  },
                  decoration: const InputDecoration(hintText: "Фамилия и имя студента"),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) => value?.isEmpty ?? true ? "Необходимо заполнить поле" : null,
                  textCapitalization: TextCapitalization.words,
                )),
                const Gap(8),
                IconButton(
                    onPressed: () {
                      widget.onDeleteButtonPressed((context.findRenderObject() as RenderBox).size.height);
                    },
                    icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error))
              ]),
              trailing: Switch(
                  value: widget.students[widget.count].isAdmin,
                  onChanged: (value) {
                    setState(() {
                      widget.students[widget.count] = widget.students[widget.count].copyWith(isAdmin: value);
                    });
                  }),
            ),
          ],
        ));
  }
}
