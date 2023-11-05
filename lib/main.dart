import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/navigation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final userDataBase = await UserDataBase.configuredUserDataBase();
  LocalDatabase lessonDatabase = LocalDatabase();

  runApp(BlocProvider(
      create: (context) =>
          QueueBloc(userDataBase, lessonDatabase, LoadingState())
            ..add(FindUserEvent()),
      child: Consumer<QueueBloc>(
        builder: (context, value, child) {
          return MyApp(value);
        },
      )));
}

class MyApp extends StatelessWidget {
  const MyApp(this.bloc, {super.key});
  final QueueBloc bloc;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: router(bloc),
        theme: ThemeData(
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.grey,
              onSecondary: Colors.black,
              error: Colors.red,
              onError: Colors.redAccent,
              background: Colors.black,
              onBackground: Colors.white,
              surface: Colors.black38,
              onSurface: Colors.white),
          textTheme: Typography.dense2021.copyWith(
              headlineLarge: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(
                      color: Colors.white, backgroundColor: Colors.black87),
              bodyMedium: Theme.of(context).textTheme.bodyMedium,
              bodyLarge: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
              headlineSmall: Theme.of(context).textTheme.headlineSmall),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(color: Colors.black),
              backgroundColor: Colors.white.withOpacity(0.8),
              side: const BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
          useMaterial3: true,
        ));
    // home: const LoginScreen(),
  }
}
