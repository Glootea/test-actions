import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:queue/data/database/new_database_service.dart';
import 'package:queue/new_domain/today_screen_cubit.dart';
import 'package:queue/new_domain/user_cubit.dart';
import 'package:queue/presentation/screens/today_screen/today_screen.dart';

part 'navigation.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<TodayScreenRoute>(path: '/', routes: [])
@immutable
class TodayScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Provider(
      create: (context) => TodayScreenCubit(
        databaseService: context.read<NewDatabaseService>(),
        userCubit: context.read<UserCubit>(),
      )..init(),
      child: const TodayScreen(),
    );
  }
}
