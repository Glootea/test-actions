import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/create_group_screen.dart';
import 'package:queue/presentation/screens/invite_screen.dart';
import 'package:queue/presentation/screens/welcome_screen.dart';
import 'package:queue/presentation/screens/main_screen.dart';
import 'package:queue/presentation/screens/upload_screen.dart';
import 'package:go_router/go_router.dart';

class _Routes {
  static String mainScreen = '/home';
  static String loginScreen = '/login';
  static String uploadScreen = '/upload/:info';
  static String inviteScreen = '/invite';
  static String loadingScreen = '/';
  static String createGroupScreen = '$loginScreen/$createGroupSubPath';
  static String createGroupSubPath = 'create';
}

GoRouter getRouter(Bloc bloc) => GoRouter(
      redirect: (BuildContext context, GoRouterState state) {
        final bloc = context.read<QueueBloc>();
        final blocState = bloc.state;
        if (state.fullPath == _Routes.uploadScreen && state.pathParameters.isNotEmpty && blocState is! UploadFromLinkState) {
          bloc.add(UploadFromLinkEvent(state.pathParameters['info']!));
        } else {
          if (blocState is MainState) return _Routes.mainScreen;
          if (blocState is UserUnAuthenticatedState) {
            return (blocState.createGroupState) ? _Routes.createGroupScreen : _Routes.loginScreen;
          }
          if (blocState is UploadFromLinkState) return _Routes.uploadScreen;
          if (blocState is InviteState) return _Routes.inviteScreen;
          if (blocState is LoadingState) return _Routes.loadingScreen;
        }

        return null;
      },
      initialLocation: _Routes.mainScreen,
      refreshListenable: _GoRouterRefreshStream(bloc.stream.asyncMap<QueueState>((event) => event as QueueState)),
      routes: [
        GoRoute(
            path: _Routes.loginScreen,
            routes: [GoRoute(path: _Routes.createGroupSubPath, builder: (context, state) => const CreateGroupScreen())],
            pageBuilder: (context, state) =>
                _DefaultPageAnimation(child: const WelcomeScreen())), //TODO: fix page transition on macos. Used to swipe from right
        GoRoute(path: _Routes.loadingScreen, pageBuilder: (context, state) => _DefaultPageAnimation(child: const LoadingView())),
        GoRoute(path: _Routes.mainScreen, builder: (context, state) => const MainScreen()),
        GoRoute(path: _Routes.uploadScreen, builder: (context, state) => UploadScreen(state.uri.queryParameters['info'])),
        GoRoute(path: _Routes.inviteScreen, builder: (context, state) => InviteScreen(state.uri.queryParameters['info'] ?? '')),
      ],
    );

class _GoRouterRefreshStream extends ChangeNotifier {
  QueueState? last;
  _GoRouterRefreshStream(Stream<QueueState> stream) {
    _subscription = stream.asBroadcastStream().listen(
      (QueueState current) {
        // if (last.runtimeType != current.runtimeType) {
        //   last = current;
        //   notifyListeners();
        // }
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _DefaultPageAnimation extends CustomTransitionPage {
  _DefaultPageAnimation({required Widget child})
      : super(
          key: const ValueKey('loading'),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
          child: child,
        );
}
