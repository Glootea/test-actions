// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $todayScreenRoute,
    ];

RouteBase get $todayScreenRoute => GoRouteData.$route(
      path: '/',
      factory: $TodayScreenRouteExtension._fromState,
    );

extension $TodayScreenRouteExtension on TodayScreenRoute {
  static TodayScreenRoute _fromState(GoRouterState state) => TodayScreenRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
