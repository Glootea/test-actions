import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StudentAdminPage extends StatelessWidget {
  const StudentAdminPage({super.key});
  List<Widget> getChildren(BuildContext context) => [
        Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Студенты",
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ))
      ];
  @override
  Widget build(BuildContext context) {
    final children = getChildren(context);
    return ListView.builder(itemBuilder: (context, index) => children[index], itemCount: children.length);
  }
}
