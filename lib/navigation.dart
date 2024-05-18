import 'package:auto_route/auto_route.dart';
import 'package:queue/presentation/screens/main/main_screen.dart';
import 'package:queue/presentation/screens/main/page/admin/admin_page.dart';
import 'package:queue/presentation/screens/main/page/admin/page/queue_page.dart';
import 'package:queue/presentation/screens/main/page/admin/page/student_page.dart';
import 'package:queue/presentation/screens/main/page/admin/page/suqbject_page.dart';
import 'package:queue/presentation/screens/main/page/admin/page/telegram_bot_page.dart';
import 'package:queue/presentation/screens/main/page/qr_scanner/scanner_page.dart';
import 'package:queue/presentation/screens/main/page/today_page/today_page.dart';
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
            AutoRoute(page: AdminRoute.page, path: 'admin', children: [
              AutoRoute(page: QueueAdminRoute.page, path: 'queue'),
              AutoRoute(page: SubjectAdminRoute.page, path: 'subject'),
              AutoRoute(page: StudentAdminRoute.page, path: 'student'),
              AutoRoute(page: TelegramBotAdminRoute.page, path: 'telegramBot'),
            ]),
            AutoRoute(page: QrScannerRoute.page, path: 'QRScanner'),
            AutoRoute(page: TodayRoute.page, path: 'todayLessons'),
          ],
        ),
      ];
}
