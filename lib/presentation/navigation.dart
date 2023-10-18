import 'package:flutter/material.dart';
import 'package:queue/logic/bloc.dart';
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
          // String query = settings.arguments.toString(); TODO: update to bloc
          // if (query.isNotEmpty) {
          //   log(query.substring(query.indexOf('info=') + 5));
          //   query =
          //       Encryption.decrypt(query.substring(query.indexOf('info=') + 5));
          //   log(query);
          //   final result = OnlineDataBase.uploadFromQuery(query);
          //   // result.then((value) => showDialog(context: context,
          //   //   builder: (context) =>  Container(
          //   //         showCloseIcon: true,
          //   //         content: Text(value
          //   //             ? "Спасибо за помощь!"
          //   //             : "Не удалось загрузить данные"))));
          //   result.then((value) {
          //     log("finished");
          //     MaterialPageRoute(
          //         builder: ((_) => BlocConsumer<QueueBloc, QueueState>(
          //             listener: (context, state) => {},
          //             builder: (localContext, _) {
          //               print("in consumer");
          //               bloc.add(FindUserEvent());
          //               print("in consumer");
          //               return const Placeholder();
          //             })));
          //   });
          // }
          // String query = settings.arguments.toString();

          // return MaterialPageRoute(
          //     builder: (context) => UploadScreen(query.isEmpty
          //         ? null
          //         : query.substring(query.indexOf('info=') + 5)));
        }

      default:
        throw Exception("Unknown route exception");
    }
  }

  void dispose() {
    bloc.close();
  }
}
