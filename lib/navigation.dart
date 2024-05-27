import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/screens/admin/admin_page.dart';
import 'package:queue/presentation/screens/admin/subpages/queue_page.dart';
import 'package:queue/presentation/screens/admin/subpages/student_page.dart';
import 'package:queue/presentation/screens/admin/subpages/suqbject_page.dart';
import 'package:queue/presentation/screens/admin/subpages/telegram_bot_page.dart';
import 'package:queue/presentation/screens/today_screen/src/body/qr_scanner/scanner_page.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/detailed_page/detailed_queue_screen.dart';
import 'package:queue/presentation/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/today_screen/today_page.dart';
part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Основной, корневой маршрут
        AutoRoute(page: TodayRoute.page, path: '/today', initial: true),
        AutoRoute(page: DetailedQueueRoute.page, path: '/today/detailed', fullMatch: true),
        AutoRoute(page: QrScannerRoute.page, path: '/today/scanner', fullMatch: true),
      ];
}
