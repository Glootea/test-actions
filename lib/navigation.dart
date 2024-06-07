import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/presentation/screens/main_screen/main_screen.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/admin_page.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/subpages/queue_page.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/subpages/student_page.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/subpages/subject/choose_subject_screen.dart';
import 'package:queue/presentation/screens/main_screen/screens/admin/subpages/subject/subject_page.dart';
import 'package:queue/presentation/screens/main_screen/screens/deadline_screen/deadline_screen.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/app_bar/end_drawer/calendar_integration_settings/calendar_integration_settings.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/app_bar/end_drawer/theme_settings/theme_settings_screen.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/detailed_page/detailed_queue_screen.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/lesson_card/lesson_card_cubit.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/body/qr_scanner/scanner_page.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/today_page.dart';
import 'package:queue/presentation/screens/welcome/init_loading_screen/init_loading_screen.dart';
import 'package:queue/presentation/screens/welcome/welcome_screen.dart';

part 'navigation.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({required this.userCubit, super.navigatorKey});

  final UserCubit userCubit;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(
          page: MainRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(page: TodayRoute.page, path: 'today', initial: true),
            AutoRoute(page: AdminRoute.page, path: 'admin'),
            AutoRoute(page: DeadlineRoute.page, path: 'deadlines'),
          ],
        ),
        AutoRoute(page: InitLoadingRoute.page, path: '/initialLoading'),
        AutoRoute(page: DetailedQueueRoute.page, path: '/today/detailed', fullMatch: true),
        AutoRoute(page: QrScannerRoute.page, path: '/today/scanner', fullMatch: true),
        AutoRoute(page: QueueAdminRoute.page, path: '/admin/queue'),
        AutoRoute(page: StudentAdminRoute.page, path: '/admin/students'),
        AutoRoute(page: ChooseSubjectRoute.page, path: '/admin/chooseSubject'),
        AutoRoute(page: SubjectAdminRoute.page, path: '/admin/subjects'),
        AutoRoute(page: ThemeSettingsRoute.page, path: '/themeSettings'),
        AutoRoute(page: CalendarIntegrationSettingsRoute.page, path: '/calendarIntegrationSettings'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (userCubit.state != null || resolver.route.name == WelcomeRoute.name) {
      resolver.next();
    } else {
      resolver.redirect(const WelcomeRoute());
    }
  }
}

@RoutePage()
class AuthorizedRoutes extends StatelessWidget implements AutoRouteWrapper {
  const AuthorizedRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Authorized Routes')));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
