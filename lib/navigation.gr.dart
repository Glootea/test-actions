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
    QueueAdminRoute.name: (routeData) {
      final args = routeData.argsAs<QueueAdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QueueAdminPage(
          data: args.data,
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
          data: args.data,
          key: args.key,
        ),
      );
    },
    TelegramBotAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TelegramBotAdminPage(),
      );
    },
    TodayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TodayScreen(),
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
/// [QueueAdminPage]
class QueueAdminRoute extends PageRouteInfo<QueueAdminRouteArgs> {
  QueueAdminRoute({
    required LessonCardData data,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          QueueAdminRoute.name,
          args: QueueAdminRouteArgs(
            data: data,
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
    required this.data,
    this.key,
  });

  final LessonCardData data;

  final Key? key;

  @override
  String toString() {
    return 'QueueAdminRouteArgs{data: $data, key: $key}';
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
    required LessonCardData data,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SubjectAdminRoute.name,
          args: SubjectAdminRouteArgs(
            data: data,
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
    required this.data,
    this.key,
  });

  final LessonCardData data;

  final Key? key;

  @override
  String toString() {
    return 'SubjectAdminRouteArgs{data: $data, key: $key}';
  }
}

/// generated route for
/// [TelegramBotAdminPage]
class TelegramBotAdminRoute extends PageRouteInfo<void> {
  const TelegramBotAdminRoute({List<PageRouteInfo>? children})
      : super(
          TelegramBotAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'TelegramBotAdminRoute';

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
