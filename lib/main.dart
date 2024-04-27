import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/new_database_service.dart';
import 'package:queue/data/database/sources/local_database/new_local_database.dart';
import 'package:queue/data/database/sources/online_database/new_online_database.dart';
import 'package:queue/firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:queue/navigation.dart';
import 'package:queue/new_domain/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    log(e.toString());
  }
  NewLocalDatabase localDatabase = NewLocalDatabase();
  NewOnlineDataBase onlineDatabase = NewOnlineDataBase();
  NewDatabaseService databaseService = NewDatabaseService(localDatabase: localDatabase, onlineDataBase: onlineDatabase);
  UserCubit userDataBase = UserCubit(localDatabase);

  // final userDataBase = await UserDataBase.getConfiguredUserDataBase(databaseService.localDatabase);
  runApp(MultiProvider(
      providers: [Provider.value(value: databaseService), Provider.value(value: userDataBase)], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final typographyTheme = Typography.dense2021
        .copyWith(
            headlineLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
            displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
            displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
            titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            headlineMedium: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))
        .apply(fontFamily: 'Roboto');
    return MaterialApp.router(
        title: "QueueMinder",
        builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            ),
        routerConfig: router,
        theme: ThemeData(
            fontFamily: 'Roboto',
            colorScheme: _colorTheme,
            textTheme: typographyTheme,
            timePickerTheme: TimePickerThemeData(dayPeriodColor: Theme.of(context).colorScheme.primaryContainer)));
  }
}

const _colorTheme = ColorScheme(
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
    onPrimaryContainer: Colors.white);
