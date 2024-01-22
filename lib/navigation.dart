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
import 'package:queue/presentation/widgets/dialog_page.dart';
import 'package:queue/presentation/widgets/qr_code_dialog.dart';

class _Routes {
  static const String mainScreen = '/home';
  static const String qrDialog = 'qr';
  static const String showQrDialog = '$mainScreen/$qrDialog';
  static const String loginScreen = '/login';
  static const String uploadScreen = '/upload/:info';
  static const String inviteScreen = '/invite';
  static const String loadingScreen = '/';
  static const String createGroupScreen = '$loginScreen/$createGroupSubPath';
  static const String createGroupSubPath = 'create';
}

GoRouter getRouter(Bloc bloc) => GoRouter(
      redirect: (BuildContext context, GoRouterState state) {
        final bloc = context.read<QueueBloc>();
        final blocState = bloc.state;
        if (state.fullPath == _Routes.uploadScreen && state.pathParameters.isNotEmpty && blocState is! UploadFromLinkState) {
          bloc.add(UploadFromLinkEvent(state.pathParameters['info']!));
        }
        switch (blocState.runtimeType) {
          case ShowQRCodeState:
            return _Routes.showQrDialog;
          case MainState:
            return _Routes.mainScreen;
          case UserUnAuthenticatedState:
            {
              return ((blocState as UserUnAuthenticatedState).createGroupState) ? _Routes.createGroupScreen : _Routes.loginScreen;
            }
          case UploadFromLinkState:
            return _Routes.uploadScreen;
          case InviteState:
            return _Routes.inviteScreen;
          case LoadingState:
            return _Routes.loadingScreen;
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
        GoRoute(path: _Routes.mainScreen, builder: (context, state) => const MainScreen(), routes: [
          GoRoute(
            path: _Routes.qrDialog,
            pageBuilder: (context, state) => DialogPage(builder: (_) => const QrCodeDialog()),
          )
        ]),
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
