import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/new_database_service.dart';
import 'package:queue/domain/user_cubit.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/screens/main/main_screen_cubit.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final databaseService = context.read<DatabaseService>();
    final cubit = TodayScreenCubit(
      databaseService: databaseService,
      userCubit: userCubit,
    );
    return BlocProvider.value(
        value: cubit,
        child: BlocListener<TodayScreenCubit, TodayScreenState>(
          listener: (context, state) {},
          child: LoadingContainer<TodayScreenCubit, TodayScreenState>(
              cubit: cubit,
              child: AutoTabsRouter.pageView(
                routes: [if (userCubit.isAdmin) const AdminRoute(), const TodayRoute(), const ScannerRoute()],
                builder: (context, child, _) {
                  final tabsRouter = AutoTabsRouter.of(context);
                  return Scaffold(
                    body: child,
                    bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: Theme.of(context).colorScheme.primary,
                        currentIndex: tabsRouter.activeIndex,
                        onTap: tabsRouter.setActiveIndex,
                        items: [
                          if (userCubit.isAdmin)
                            const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: ''),
                          const BottomNavigationBarItem(icon: Icon(Icons.today), label: ''),
                          const BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ''),
                        ]),
                  );
                },
              )),
        ));
  }
}
