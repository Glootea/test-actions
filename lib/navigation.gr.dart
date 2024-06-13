// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'navigation.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdminPage(),
      );
    },
    CalendarIntegrationSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalendarIntegrationSettingsScreen(),
      );
    },
    ChooseSubjectRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseSubjectRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChooseSubjectScreen(
          onTap: args.onTap,
          key: args.key,
        ),
      );
    },
    DeadlineRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DeadlineScreen(),
      );
    },
    DetailedQueueRoute.name: (routeData) {
      final args = routeData.argsAs<DetailedQueueRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailedQueueScreen(
          args.cubit,
          key: args.key,
        ),
      );
    },
    InitLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<InitLoadingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InitLoadingScreen(
          userCubit: args.userCubit,
          intent: args.intent,
          key: args.key,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    QueueAdminRoute.name: (routeData) {
      final args = routeData.argsAs<QueueAdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QueueAdminPage(
          subjectID: args.subjectID,
          key: args.key,
        ),
      );
    },
    QrScannerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScannerPage(),
      );
    },
    StudentAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StudentAdminPage(),
      );
    },
    SubjectAdminRoute.name: (routeData) {
      final args = routeData.argsAs<SubjectAdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SubjectAdminScreen(
          subjectID: args.subjectID,
          key: args.key,
        ),
      );
    },
    ThemeSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ThemeSettingsScreen(),
      );
    },
    TodayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TodayScreen(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [AdminPage]
class AdminRoute extends PageRouteInfo<void> {
  const AdminRoute({List<PageRouteInfo>? children})
      : super(
          AdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CalendarIntegrationSettingsScreen]
class CalendarIntegrationSettingsRoute extends PageRouteInfo<void> {
  const CalendarIntegrationSettingsRoute({List<PageRouteInfo>? children})
      : super(
          CalendarIntegrationSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarIntegrationSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChooseSubjectScreen]
class ChooseSubjectRoute extends PageRouteInfo<ChooseSubjectRouteArgs> {
  ChooseSubjectRoute({
    required void Function(int) onTap,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChooseSubjectRoute.name,
          args: ChooseSubjectRouteArgs(
            onTap: onTap,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChooseSubjectRoute';

  static const PageInfo<ChooseSubjectRouteArgs> page =
      PageInfo<ChooseSubjectRouteArgs>(name);
}

class ChooseSubjectRouteArgs {
  const ChooseSubjectRouteArgs({
    required this.onTap,
    this.key,
  });

  final void Function(int) onTap;

  final Key? key;

  @override
  String toString() {
    return 'ChooseSubjectRouteArgs{onTap: $onTap, key: $key}';
  }
}

/// generated route for
/// [DeadlineScreen]
class DeadlineRoute extends PageRouteInfo<void> {
  const DeadlineRoute({List<PageRouteInfo>? children})
      : super(
          DeadlineRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeadlineRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailedQueueScreen]
class DetailedQueueRoute extends PageRouteInfo<DetailedQueueRouteArgs> {
  DetailedQueueRoute({
    required LessonCardCubit cubit,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailedQueueRoute.name,
          args: DetailedQueueRouteArgs(
            cubit: cubit,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailedQueueRoute';

  static const PageInfo<DetailedQueueRouteArgs> page =
      PageInfo<DetailedQueueRouteArgs>(name);
}

class DetailedQueueRouteArgs {
  const DetailedQueueRouteArgs({
    required this.cubit,
    this.key,
  });

  final LessonCardCubit cubit;

  final Key? key;

  @override
  String toString() {
    return 'DetailedQueueRouteArgs{cubit: $cubit, key: $key}';
  }
}

/// generated route for
/// [InitLoadingScreen]
class InitLoadingRoute extends PageRouteInfo<InitLoadingRouteArgs> {
  InitLoadingRoute({
    required UserCubit userCubit,
    required InitLoadingScreenIntent intent,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          InitLoadingRoute.name,
          args: InitLoadingRouteArgs(
            userCubit: userCubit,
            intent: intent,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'InitLoadingRoute';

  static const PageInfo<InitLoadingRouteArgs> page =
      PageInfo<InitLoadingRouteArgs>(name);
}

class InitLoadingRouteArgs {
  const InitLoadingRouteArgs({
    required this.userCubit,
    required this.intent,
    this.key,
  });

  final UserCubit userCubit;

  final InitLoadingScreenIntent intent;

  final Key? key;

  @override
  String toString() {
    return 'InitLoadingRouteArgs{userCubit: $userCubit, intent: $intent, key: $key}';
  }
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QueueAdminPage]
class QueueAdminRoute extends PageRouteInfo<QueueAdminRouteArgs> {
  QueueAdminRoute({
    required int subjectID,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          QueueAdminRoute.name,
          args: QueueAdminRouteArgs(
            subjectID: subjectID,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'QueueAdminRoute';

  static const PageInfo<QueueAdminRouteArgs> page =
      PageInfo<QueueAdminRouteArgs>(name);
}

class QueueAdminRouteArgs {
  const QueueAdminRouteArgs({
    required this.subjectID,
    this.key,
  });

  final int subjectID;

  final Key? key;

  @override
  String toString() {
    return 'QueueAdminRouteArgs{subjectID: $subjectID, key: $key}';
  }
}

/// generated route for
/// [ScannerPage]
class QrScannerRoute extends PageRouteInfo<void> {
  const QrScannerRoute({List<PageRouteInfo>? children})
      : super(
          QrScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScannerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StudentAdminPage]
class StudentAdminRoute extends PageRouteInfo<void> {
  const StudentAdminRoute({List<PageRouteInfo>? children})
      : super(
          StudentAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SubjectAdminScreen]
class SubjectAdminRoute extends PageRouteInfo<SubjectAdminRouteArgs> {
  SubjectAdminRoute({
    required int subjectID,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SubjectAdminRoute.name,
          args: SubjectAdminRouteArgs(
            subjectID: subjectID,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SubjectAdminRoute';

  static const PageInfo<SubjectAdminRouteArgs> page =
      PageInfo<SubjectAdminRouteArgs>(name);
}

class SubjectAdminRouteArgs {
  const SubjectAdminRouteArgs({
    required this.subjectID,
    this.key,
  });

  final int subjectID;

  final Key? key;

  @override
  String toString() {
    return 'SubjectAdminRouteArgs{subjectID: $subjectID, key: $key}';
  }
}

/// generated route for
/// [ThemeSettingsScreen]
class ThemeSettingsRoute extends PageRouteInfo<void> {
  const ThemeSettingsRoute({List<PageRouteInfo>? children})
      : super(
          ThemeSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TodayScreen]
class TodayRoute extends PageRouteInfo<void> {
  const TodayRoute({List<PageRouteInfo>? children})
      : super(
          TodayRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodayRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
