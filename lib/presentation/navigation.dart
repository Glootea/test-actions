import 'package:flutter/material.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/presentation/screens/invite_screen.dart';
import 'package:queue/presentation/screens/login_screen.dart';
import 'package:queue/presentation/screens/main_screen.dart';
import 'package:queue/presentation/screens/upload_screen.dart';

class Routes {
  static String mainScreen = 'home';
  static String loginScreen = '';
  static String uploadScreen = 'upload';
}

class AppRouter {
  final QueueBloc bloc;
  AppRouter(this.bloc);

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' || '':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case 'home':
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case 'upload':
        {
          return MaterialPageRoute(
              builder: (context) =>
                  UploadScreen(settings.arguments.toString()));
        }
      case 'invite':
        {
          return MaterialPageRoute(
              builder: (context) =>
                  InviteScreen(settings.arguments.toString()));
        }
      default:
        throw Exception("Unknown route exception");
    }
  }

  void dispose() {
    bloc.close();
  }
}
