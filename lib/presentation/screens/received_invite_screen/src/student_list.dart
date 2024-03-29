import 'package:flutter/material.dart';
import 'package:queue/entities/src/student.dart';
import 'package:queue/presentation/screens/received_invite_screen/src/select_student_tile.dart';

class StudentList extends StatelessWidget {
  const StudentList({required this.students, required this.onItemTap, super.key});

  final List<StudentEntity> students;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: students.length,
      itemBuilder: (context, index) => SelectStudentTile(student: students[index], onTap: () => onItemTap(index)),
    );
  }
}
