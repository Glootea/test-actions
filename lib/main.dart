import 'dart:developer';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/online_database/online_database.dart';
import 'package:queue/domain/group_metainfo/group_metainfo.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:queue/domain/theme/theme_state.dart';
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
  final localDatabase = LocalDatabase();
  final onlineDatabase = OnlineDataBase();
  final keyValueStorage = KeyValueStorage(localDatabase);
  final databaseService = DatabaseService(localDatabase: localDatabase, onlineDataBase: onlineDatabase);
  final (themeCubit, userCubit, groupMetaInfoCubit) = await (
    ThemeCubit.create(keyValueStorage),
    UserCubit.create(keyValueStorage),
    GroupMetaInfoCubit.create(keyValueStorage),
  ).wait;

  final appRouter = AppRouter(userCubit: userCubit).config();
  runApp(
    MultiBlocProvider(
      providers: [
        Provider.value(value: databaseService),
        Provider.value(value: keyValueStorage),
        BlocProvider.value(value: userCubit),
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: groupMetaInfoCubit),
      ],
      child: MyApp(router: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.router, super.key});
  final RouterConfig<Object>? router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            final colorScheme = state.getScheme ??
                (((state.brightness) == Brightness.dark) ? darkDynamic : lightDynamic) ??
                const ColorScheme.dark();
            return MaterialApp.router(
              title: 'QueueMinder',
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child ?? Container(),
              ),
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Roboto',
                colorScheme: colorScheme,
                timePickerTheme: TimePickerThemeData(dayPeriodColor: Theme.of(context).colorScheme.primaryContainer),
              ),
            );
          },
        );
      },
    );
  }
}
