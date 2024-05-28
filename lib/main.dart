import 'dart:developer';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/firebase_options.dart';
import 'package:queue/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    log(e.toString());
  }
  LocalDatabase localDatabase = LocalDatabase();
  OnlineDataBase onlineDatabase = OnlineDataBase();
  KeyValueStorage keyValueStorage = KeyValueStorage(localDatabase);
  DatabaseService databaseService = DatabaseService(localDatabase: localDatabase, onlineDataBase: onlineDatabase);
  UserCubit userCubit = UserCubit(keyValueStorage);
  final themeCubit = ThemeCubit(keyValueStorage);
  await (themeCubit.init(), userCubit.init()).wait;
  runApp(MultiBlocProvider(providers: [
    Provider.value(value: databaseService),
    Provider.value(value: keyValueStorage),
    BlocProvider.value(value: userCubit),
    BlocProvider.value(value: themeCubit),
    BlocProvider(create: (_) => GroupMetaInfoCubit(keyValueStorage)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final colorScheme = state.getScheme ??
            (((state.brightness) == Brightness.dark) ? darkDynamic : lightDynamic) ??
            const ColorScheme.dark();
        return MaterialApp.router(
            title: "QueueMinder",
            builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container(),
                ),
            routerConfig: appRouter.config(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Roboto',
                colorScheme: colorScheme,
                timePickerTheme: TimePickerThemeData(dayPeriodColor: Theme.of(context).colorScheme.primaryContainer)));
      });
    });
  }
}
