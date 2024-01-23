import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/providers/online_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';

class ReceivedInviteScreen extends StatelessWidget {
  const ReceivedInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final infoTableID = (context.read<QueueBloc>().state as ReceivedInviteState).tableID;
    log(infoTableID);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: OnlineDataBase.instance(tableID: infoTableID).then((value) => value.getStudents()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final studentNames = snapshot.data!;
                return Column(children: [
                  const Gap(16),
                  Text(
                    "Выберите себя: ",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  // const Gap(16),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: studentNames.length,
                          itemBuilder: (context, index) => ListTile(
                              title: GestureDetector(
                                  onTap: () => (studentNames[index].isAdmin == false)
                                      ? context.read<QueueBloc>().add(RegisterInvitedUserEvent(infoTableID, studentNames[index].name))
                                      : null,
                                  child: ColoredBox(
                                    color: Colors.transparent,
                                    child: Row(children: [
                                      Text(studentNames[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(color: Theme.of(context).colorScheme.primary.withAlpha(studentNames[index].isAdmin ? 160 : 255))),
                                      if (studentNames[index].isAdmin) const Gap(16),
                                      if (studentNames[index].isAdmin) const Icon(Icons.verified_user_outlined, size: 24),
                                      if (studentNames[index].isAdmin) const Gap(16),
                                      if (studentNames[index].isAdmin)
                                        const Tooltip(
                                            message: "Админы могут получить доступ только по прямой ссылке",
                                            triggerMode: TooltipTriggerMode.tap,
                                            child: Icon(Icons.info_outline, size: 24))
                                    ]),
                                  )))))
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
