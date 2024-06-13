import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/navigation.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [AdminRoute(), TodayRoute(), DeadlineRoute()],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        final width = MediaQuery.sizeOf(context).width;
        final isWide = width > 600;
        final ultraWide = width > 1000;
        final navigationItems = [
          (const Icon(Icons.admin_panel_settings_outlined), 'Админ'),
          (const Icon(Icons.calendar_month_outlined), 'Сегодня'),
          (const Icon(Icons.schedule_outlined), 'Дедлайны'),
        ];
        return Scaffold(
          body: isWide
              ? Row(
                  children: [
                    NavigationRail(
                      labelType: ultraWide ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                      selectedIndex: tabsRouter.activeIndex,
                      useIndicator: true,
                      onDestinationSelected: tabsRouter.setActiveIndex,
                      extended: ultraWide,
                      selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primaryContainer),
                      indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      destinations: navigationItems
                          .map((item) => NavigationRailDestination(icon: item.$1, label: Text(item.$2)))
                          .toList(),
                    ),
                    Expanded(child: child),
                  ],
                )
              : child,
          bottomNavigationBar: (!isWide)
              ? BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: navigationItems.map((item) => BottomNavigationBarItem(icon: item.$1, label: item.$2)).toList(),
                )
              : null,
        );
      },
    );
  }
}
