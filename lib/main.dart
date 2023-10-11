import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/lesson_database.dart';
import 'package:queue/data/online_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/encryprion.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/login_screen.dart';
import 'package:queue/presentation/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userDataBase = await UserDataBase.configuredUserDataBase();
  LessonDatabase lessonDatabase;
  if (userDataBase != null) {
    lessonDatabase =
        await LessonDatabase.fillFromLocal(userDataBase.getUserName);
  } else {
    lessonDatabase = await LessonDatabase.fillFromLocal("noName");
  }

  runApp(MyApp(
    userDataBase,
    lessonDatabase,
  ));
}

class MyApp extends StatelessWidget {
  final LessonDatabase _lessonDatabase;
  final UserDataBase? _userDataBase;
  const MyApp(this._userDataBase, this._lessonDatabase, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QueueBloc(_userDataBase, _lessonDatabase, LoadingState()),
      child: MaterialApp(
        title: 'Queue',
        initialRoute: "/",
        routes: {
          "/": (context) => const LoginScreen(),
          '/home': (context) => const MainScreen(),
          '/upload': (context) => const LoginScreen()
        },
        onGenerateRoute: (settings) {
          // log(Encryption.decrypt(latin1.encode(
          //     'idfXiAn2tb3dIIb7rBdB9eLBRq+jP9U22CDd7GrYPZ+uvl1LU9v43z/wSEKSPFE9J/p1JbJ+EIKgeZBHRgWzekXEsOzN3ybGRNweiY5KEUPswN59kAQExlQSHhY=')));
          if (settings.name?.contains("upload") ?? false) {
            String query = settings.name ?? '';
            if (query.isEmpty) return;
            log(query.substring(query.indexOf('info=') + 5));
            query =
                Encryption.decrypt(query.substring(query.indexOf('info=') + 5));
            log(query);
            final result = OnlineDataBase.uploadFromQuery(query);
            // result.then((value) => showDialog(context: context,
            //   builder: (context) =>  Container(
            //         showCloseIcon: true,
            //         content: Text(value
            //             ? "Спасибо за помощь!"
            //             : "Не удалось загрузить данные"))));
            result.then((value) => log("finished"));
          }
          return null;
        },
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
              headlineSmall: Theme.of(context).textTheme.headlineSmall),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.8),
              side: const BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
          useMaterial3: true,
        ),
        // home: const LoginScreen(),
      ),
    );
  }
}
