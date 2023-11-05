import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/invite_screen.dart';
import 'package:queue/presentation/screens/login_screen.dart';
import 'package:queue/presentation/screens/main_screen.dart';
import 'package:queue/presentation/screens/upload_screen.dart';
import 'package:go_router/go_router.dart';

class _Routes {
  static String mainScreen = '/home';
  static String loginScreen = '/';
  static String uploadScreen = '/upload/:info';
  static String inviteScreen = '/invite';
  static String loadingScreen = '/loading';
}

// class AppRouter {
//   final QueueBloc bloc;
//   AppRouter(this.bloc);

//   Route onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/' || '':
//         return MaterialPageRoute(builder: (context) => const LoginScreen());
//       case 'home':
//         return MaterialPageRoute(builder: (context) => const MainScreen());
//       case 'upload':
//         {
//           return MaterialPageRoute(
//               builder: (context) =>
//                   UploadScreen(settings.arguments.toString()));
//         }
//       case 'invite':
//         {
//           return MaterialPageRoute(
//               builder: (context) =>
//                   InviteScreen(settings.arguments.toString()));
//         }
//       default:
//         throw Exception("Unknown route exception");
//     }
//   }

//   void dispose() {
//     bloc.close();
//   }
// }

// GoRouter configuration
GoRouter router(Bloc bloc) => GoRouter(
      redirect: (BuildContext context, GoRouterState state) {
        final bloc = context.read<QueueBloc>();
        final blocState = bloc.state;
        if (state.fullPath == _Routes.uploadScreen &&
            state.pathParameters.isNotEmpty &&
            blocState is! UploadFromLinkState) {
          bloc.add(UploadFromLinkEvent(state.pathParameters['info']!));
        } else {
          if (blocState is MainState) return _Routes.mainScreen;
          if (blocState is UserUnAuthenticatedState) return _Routes.loginScreen;
          if (blocState is UploadFromLinkState) return _Routes.uploadScreen;
          if (blocState is InviteState) return _Routes.inviteScreen;
          if (blocState is LoadingState) return _Routes.loadingScreen;
        }

        return null;
      },
      initialLocation: _Routes.mainScreen,
      refreshListenable: _GoRouterRefreshStream(bloc.stream),
      routes: [
        GoRoute(
            path: _Routes.loginScreen,
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: _Routes.loadingScreen,
            builder: (context, state) => const LoadingView()),
        GoRoute(
            path: _Routes.mainScreen,
            builder: (context, state) => const MainScreen()),
        GoRoute(
            path: _Routes.uploadScreen,
            builder: (context, state) =>
                UploadScreen(state.uri.queryParameters['info'])),
        GoRoute(
            path: _Routes.inviteScreen,
            builder: (context, state) =>
                InviteScreen(state.uri.queryParameters['info'] ?? '')),
      ],
    );

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
