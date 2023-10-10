import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/lesson_database.dart';
import 'package:queue/data/online_database.dart';
import 'package:queue/data/user_database.dart';

import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/login_screen.dart';

import 'package:queue/presentation/main_screen.dart';

import 'logic/encryprion.dart';

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
          print(settings.name);
          final settingsUri = Uri.parse(settings.name!);
          if (settings.name?.contains("upload") ?? true) {
            String? query = settingsUri.queryParameters['info'];
            if (query == null) return;
            query = Encryption.decrypt(Uint8List.fromList(query.codeUnits));
            final result = OnlineDataBase.uploadFromQuery(query);
            result.then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    showCloseIcon: true,
                    content: Text(value
                        ? "Спасибо за помощь!"
                        : "Не удалось загрузить данные"))));
          }
          return null;
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              // seedColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              //     .withOpacity(1.0),
              seedColor: Colors.white,
              brightness: Brightness.dark),
          useMaterial3: true,
        ),
        // home: const LoginScreen(),
      ),
    );
  }
}
