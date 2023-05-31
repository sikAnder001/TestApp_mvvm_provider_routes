import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_api_project_mvvm/view/home_screen.dart';
import 'package:flutter_api_project_mvvm/view/login_screen.dart';
import 'package:flutter_api_project_mvvm/view/splash_view.dart';

import '../../view/detail_view.dart';

class Routes {
  static Route<dynamic>  generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext builder) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext builder) => const LoginScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext builder) => const SplashView());
      case RoutesName.detailScreen:
        return MaterialPageRoute(
            builder: (BuildContext builder) => const DetailScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route Found"),
            ),
          );
        });
    }
  }
}
