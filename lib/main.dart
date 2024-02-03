import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/user_database.dart';
import 'package:queue/firebase_options.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/navigation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    log(e.toString());
  }
  DataBaseService databaseService = await DataBaseService.instance();
  final userDataBase = await UserDataBase.getConfiguredUserDataBase(databaseService.localDatabase);
  runApp(MyApp(userDataBase, databaseService));
}

class MyApp extends StatelessWidget {
  const MyApp(this.userDataBase, this.databaseService, {super.key});
  final DataBaseService databaseService;
  final UserDataBase userDataBase;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bloc = QueueBloc(userDataBase, databaseService, LoadingState());
    final router = getRouter(bloc);
    return BlocProvider(
      create: (context) => bloc..add(FindUserEvent()),
      child: Consumer(
        builder: (context, a, b) => MaterialApp.router(
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child ?? Container()),
            routerConfig: router,
            theme: ThemeData(
                fontFamily: 'Roboto',
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
                    onSurface: Colors.white,
                    primaryContainer: Colors.black,
                    onPrimaryContainer: Colors.white),
                textTheme: Typography.dense2021
                    .copyWith(
                        // bodySmall: Theme.of(context).textTheme.body,
                        headlineLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                        displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
                        displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                        titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                        bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        headlineMedium: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                        headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))
                    .apply(fontFamily: 'Roboto'),

                // outlinedButtonTheme: OutlinedButtonThemeData(
                //   style: OutlinedButton.styleFrom(
                //     textStyle: const TextStyle(color: Colors.black),
                //     backgroundColor: Colors.white.withOpacity(0.8),
                //     side: const BorderSide(color: Colors.black, width: 1.5),
                //   ),
                // ),
                useMaterial3: true,
                timePickerTheme: TimePickerThemeData(dayPeriodColor: Theme.of(context).colorScheme.primaryContainer))),
      ),
    );
    // home: const LoginScreen(),
  }
}
