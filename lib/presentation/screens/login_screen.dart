import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/navigation.dart';
import 'package:queue/presentation/widgets/padding.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QueueBloc>().add(FindUserEvent());
    return SafeArea(
      child: BlocBuilder<QueueBloc, QueueState>(buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is UserUnAuthenticatedState &&
            current is UserUnAuthenticatedState) {
          return previous.hashCode != current.hashCode;
        }
        return false;
      }, builder: (context, state) {
        if (state is MainState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
          });
        } else {
          if (state is UserUnAuthenticatedState) {
            return LoginView(
                errorMessage: state.errorMessage,
                key: ValueKey(state.hashCode));
          }
        }
        return const LoadingView();
      }),
    );
  }
}

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
              actions: [
                OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Ok"))
              ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyPadding(),
              Text(
                "Приложение очереди",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const MyPadding(),
              const MyPadding(),
              Text(
                "Введи ключ: ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const MyPadding(),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller,
                  maxLength: 32,
                  maxLines: 1,
                  onChanged: (value) => setState(() {}),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorText: controller.text.length == 32
                          ? null
                          : "Длина ключа должна составлять 32"),
                ),
              ),
              const MyPadding(),
              OutlinedButton(
                  onPressed: () => context
                      .read<QueueBloc>()
                      .add(UserAuthenticateEvent(controller.text)),
                  child: Text("Войти",
                      style: Theme.of(context).textTheme.bodyMedium)),
              const MyPadding(),
              Text(
                "Ключ отправлен в лс с #queue",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.blue),
              ),
              const MyPadding(),
              const MyPadding(),
              Text("Много буков: ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white)),
              const MyPadding(),
              Text(
                  """Приложение для ведения очереди сдачи работ для группы ИНБО-01-22 МИРЭА.\n\nПреимущества:\n- офлайн доступ\n- возможность продолжения очереди с прошлой пары\n- учитывается время записи, а не время отправки сообщения на сервер\n- возможность записать с помощью друга при отсутсвии интернета\n- организованность ведения очереди\n- независимость от наличия старост\n\nНаписано на Flutter за пару вечеров""",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white))
            ]),
      ),
    ));
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
