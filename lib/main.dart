import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/lesson_database.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/navigation.dart';

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

  runApp(BlocProvider(
      create: (context) =>
          QueueBloc(userDataBase, lessonDatabase, LoadingState()),
      child: Consumer<QueueBloc>(
        builder: (context, value, child) {
          // value.add(FindUserEvent());
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
    final router = AppRouter(bloc);
    return MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name?.isNotEmpty ?? false) {
            List<String> params = settings.name!.split('/');
            // if (params.length > 2) {
            settings = RouteSettings(
                name: params[0],
                arguments: params.length > 1
                    ? params
                        .sublist(1)
                        .reduce((value, element) => value + element)
                    : null);
            // } else if (params.length == 2) {
            //   settings = RouteSettings(name: params[1]);
            // }
          }
          return router.onGenerateRoute(settings);
        },

        // title: 'Queue',
        // initialRoute: "/",
        // routes: {
        //   "/": (context) => const LoginScreen(),
        //   '/home': (context) => const MainScreen(),
        //   '/upload': (context) => const LoginScreen()
        // },
        // onGenerateRoute: (settings) {
        //   if (settings.name?.contains("upload") ?? false) {
        //     String query = settings.name ?? '';
        //     if (query.isEmpty) return null;
        //     log(query.substring(query.indexOf('info=') + 5));
        //     query =
        //         Encryption.decrypt(query.substring(query.indexOf('info=') + 5));
        //     log(query);
        //     final result = OnlineDataBase.uploadFromQuery(query);
        //     // result.then((value) => showDialog(context: context,
        //     //   builder: (context) =>  Container(
        //     //         showCloseIcon: true,
        //     //         content: Text(value
        //     //             ? "Спасибо за помощь!"
        //     //             : "Не удалось загрузить данные"))));
        //     result.then((value) {
        //       log("finished");
        //       MaterialPageRoute(
        //           builder: ((_) => BlocConsumer<QueueBloc, QueueState>(
        //               listener: (context, state) => {},
        //               builder: (localContext, _) {
        //                 print("in consumer");
        //                 bloc.add(FindUserEvent());
        //                 print("in consumer");
        //                 return child ?? const Placeholder();
        //               })));
        //     });
        //   }
        //   return null;
        // },
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
