import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/received_invite_screen/src/student_list.dart';

class ReceivedInviteScreen extends StatelessWidget {
  const ReceivedInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QueueBloc>();
    final infoTableID = (bloc.state as ReceivedInviteState).tableID;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future:
                OnlineDataBase.instance(tableID: infoTableID).then((onlineDataBase) => onlineDataBase.getStudents()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final students = snapshot.data!;
                return Column(children: [
                  const Gap(16),
                  Text("Выберите себя: ", style: Theme.of(context).textTheme.headlineLarge),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: StudentList(
                        students: students,
                        onItemTap: (int index) => bloc.add(RegisterInvitedUserEvent(infoTableID, students[index].name)),
                      ))
                ]);
              } else if (snapshot.hasError) {
                return const Center(child: Text("Ошибка загрузки данных"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
