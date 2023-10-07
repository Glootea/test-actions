import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/lesson_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/login_screen.dart';
import 'package:queue/presentation/widgets/lesson_widget.dart';
import 'package:queue/presentation/widgets/padding.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<QueueBloc, QueueState>(
          builder: (context, state) {
            if (state is! MainState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              });
            }
            return Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: LessonDatabase().todayLessons.length,
                  itemBuilder: (context, index) =>
                      LessonWidget(LessonDatabase().todayLessons[index]),
                  separatorBuilder: (context, index) => const MyPadding(),
                ),
                OutlinedButton(
                    onPressed: () =>
                        context.read<QueueBloc>().add(UserLogOutEvent()),
                    child: const Text("Выйти из аккаунта"))
              ],
            );
          },
        ),
      ),
    );
  }
}
