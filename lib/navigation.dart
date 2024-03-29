import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/mainScreen/pages/admin_page/adminSettings/lesson_screen.dart';
import 'package:queue/presentation/screens/mainScreen/pages/admin_page/adminSettings/queue_screen.dart';
import 'package:queue/presentation/screens/mainScreen/pages/admin_page/adminSettings/students_screen.dart';
import 'package:queue/presentation/screens/mainScreen/pages/admin_page/adminSettings/telegram_bot_screen.dart';
import 'package:queue/presentation/screens/create_group_screen/create_group_screen.dart';
import 'package:queue/presentation/screens/received_invite_screen/received_invite_screen.dart';
import 'package:queue/presentation/screens/welcome_screen/welcome_screen.dart';
import 'package:queue/presentation/screens/mainScreen/main_screen.dart';
import 'package:queue/presentation/screens/upload_screen/upload_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:queue/presentation/common_src/dialog_page_generic.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/src/qr_code_dialog.dart';

class _Routes {
  static const String mainScreen = '/home'; // TODO: change and save index of subScreens
  static const String qrDialogSubpath = 'qr';
  static const String adminSubpath = 'admin/:index';
  static const String showQrDialog = '$mainScreen/$qrDialogSubpath';
  static const String adminScreen = '$mainScreen/$adminSubpath';
  static const String loginScreen = '/login';
  static const String uploadScreen = '/upload/:info';
  static const String inviteScreen = '/invite/:info';
  static const String loadingScreen = '/';
  static const String createGroupScreen = '$loginScreen/$createGroupSubPath';
  static const String createGroupSubPath = 'create';
  static const String signMeInPath = '/signMeIn';
}

GoRouter getRouter(Bloc<QueueEvent, QueueState> bloc) => GoRouter(
      redirect: (BuildContext context, GoRouterState state) {
        final blocState = bloc.state;
        if (state.pathParameters['info'] != ':info') {
          if (state.fullPath == _Routes.uploadScreen &&
              state.pathParameters.isNotEmpty &&
              blocState is! UploadFromLinkState) {
            bloc.add(UploadFromLinkEvent(state.pathParameters['info']!));
          }
          if (state.fullPath == _Routes.inviteScreen &&
              state.pathParameters.isNotEmpty &&
              blocState is! ReceivedInviteState) {
            bloc.add(ReceivedInviteEvent(state.pathParameters['info']!));
          }
        }
        if (state.matchedLocation == _Routes.signMeInPath) {
          bloc.add(SignMeInEvent());
        }

        if (state.fullPath == _Routes.uploadScreen && blocState is UploadFromLinkState) return null;
        switch (blocState.runtimeType) {
          case ShowQRCodeState:
            return _Routes.showQrDialog;
          case MainState:
            return _Routes.mainScreen;
          case UserUnAuthenticatedState:
            return ((blocState as UserUnAuthenticatedState).createGroupState)
                ? _Routes.createGroupScreen
                : _Routes.loginScreen;
          case UploadFromLinkState:
            return _Routes.uploadScreen;
          case ReceivedInviteState:
            return _Routes.inviteScreen;
          case LoadingState:
            return _Routes.loadingScreen;
          case AdminSettingState:
            return _Routes.adminScreen.replaceFirst(':index', (blocState as AdminSettingState).index.toString());
        }
        return null;
      },
      initialLocation: _Routes.mainScreen,
      refreshListenable: _GoRouterRefreshStream(bloc.stream.map<QueueState>((event) => event)),
      routes: [
        GoRoute(
            path: _Routes.loginScreen,
            routes: [GoRoute(path: _Routes.createGroupSubPath, builder: (context, state) => const CreateGroupScreen())],
            pageBuilder: (context, state) => _DefaultPageAnimation(
                child: const WelcomeScreen())), //TODO: fix page transition on macos. Used to swipe from right
        GoRoute(
            path: _Routes.loadingScreen,
            pageBuilder: (context, state) => _DefaultPageAnimation(child: const LoadingView())),
        GoRoute(
            path: _Routes.mainScreen,
            pageBuilder: (context, state) => _DefaultPageAnimation(child: const MainScreen()),
            routes: [
              GoRoute(
                path: _Routes.qrDialogSubpath,
                pageBuilder: (context, state) => DialogPage(builder: (_) => const QrCodeDialog()),
              ),
              GoRoute(
                  path: _Routes.adminSubpath,
                  builder: (context, state) => switch (state.pathParameters['index'] ?? '') {
                        '0' => const StudentScreen(),
                        '1' => const LessonScreen(),
                        '2' => const QueueScreen(),
                        '3' => const TelegramBotScreen(),
                        _ => throw GoException('Wrong index')
                      }),
            ]),
        GoRoute(path: _Routes.uploadScreen, builder: (context, state) => const UploadScreen()),
        GoRoute(path: _Routes.inviteScreen, builder: (context, state) => const ReceivedInviteScreen()),
      ],
    );

class _GoRouterRefreshStream extends ChangeNotifier {
  QueueState? last;
  _GoRouterRefreshStream(Stream<QueueState> stream) {
    _subscription = stream.asBroadcastStream().listen(
      (QueueState current) {
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
          transitionDuration: const Duration(milliseconds: 5000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: child,
        );
}
