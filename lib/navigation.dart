import 'package:auto_route/auto_route.dart';
import 'package:queue/presentation/screens/main/main_screen.dart';
import 'package:queue/presentation/screens/main/page/today_lessons/page/admin_page.dart';
import 'package:queue/presentation/screens/main/page/today_lessons/page/scanner_page.dart';
import 'package:queue/presentation/screens/main/page/today_lessons/page/today_page.dart';
part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Основной, корневой маршрут
        AutoRoute(
          page: MainRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(page: AdminRoute.page, path: 'admin'),
            AutoRoute(page: ScannerRoute.page, path: 'QRScanner'),
            AutoRoute(page: TodayRoute.page, path: 'todayLessons', initial: true),
          ],
        ),
      ];
}
