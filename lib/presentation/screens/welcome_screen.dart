import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
// import 'package:queue/navigation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<QueueBloc>().add(FindUserEvent());
    return SafeArea(
      child: BlocBuilder<QueueBloc, QueueState>(buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is UserUnAuthenticatedState && current is UserUnAuthenticatedState) {
          return previous.hashCode != current.hashCode;
        }
        return false;
      }, builder: (context, state) {
        if (state is UserUnAuthenticatedState) {
          return LoginView(errorMessage: state.errorMessage, key: ValueKey(state.hashCode));
        }

        return const LoadingView();
      }),
    );
  }
}

typedef HandleSignInFn = Future<void> Function();

class LoginView extends StatefulWidget {
  const LoginView({this.errorMessage, super.key});
  final String? errorMessage;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    String? errorMessage = widget.errorMessage;

    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(errorMessage),
              actions: [OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Ok"))],
            ),
          ));
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Widget buildSignInButton({HandleSignInFn? onPressed}) {
  //   return (GoogleSignInPlatform.instance as web.GoogleSignInPlugin)
  //       .renderButton(configuration: web.GSIButtonConfiguration());
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   // TODO: activate on go to choose student on invite
    //   context.go('https://queue-01-22.web.app/invite/1G_ny0JMccBkXSXeOr-nQPNVKOqTfiRb9chElk1HPPts');
    // });
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Align(
                      child: Image.asset('assets/panda.png', width: 150, height: 150),
                    ), // TODO: change to app icon
                    const Gap(16),
                    Text(
                      "QueueMinder",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Gap(16),
                    Text("Для студентов", style: Theme.of(context).textTheme.displaySmall),
                    const Gap(16),
                    const Text("Единственным способом авторизации является ссылка, выданная старостой"),
                    const Gap(32),
                    Text("Для старост", overflow: TextOverflow.clip, style: Theme.of(context).textTheme.displaySmall),
                    const Gap(16),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "• Для регистрации новой группы необходимо зарегистрироваться через Google аккаунт, указав нужную информацию.\n• Для хранения информации используется excel таблица, которая будет размещена на вашем Google Drive.\n• Приглашения организованы через ссылки",
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              style: Theme.of(context).outlinedButtonTheme.style,
                              onPressed: () {
                                context.read<QueueBloc>().add(CreateGroupIntentionEvent());
                              },
                              child: const Text(
                                "Новая группа",
                              ),
                            ),
                            const Gap(16),
                            OutlinedButton(
                                style: Theme.of(context).outlinedButtonTheme.style,
                                onPressed: () {
                                  context.read<QueueBloc>().add(LoginUsingGoogleEvent());
                                },
                                child: const Text(
                                  "Войти ",
                                )),
                          ],
                        ),
                      ],
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            )));
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 500), () => 1),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              );
            }
            return const Center();
          }),
    ));
  }
}
