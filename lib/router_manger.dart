import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/movie/movie_page.dart';
import 'package:flutter_learn/module/start/login_page.dart';
import 'package:flutter_learn/module/start/register_first_step_page.dart';
import 'package:flutter_learn/module/web_view_page.dart';

import 'module/start/register_first_step_page.dart';

class RouteName {
  static const String webView = 'webView';
  static const String login = 'login';
  static const String register_first_step = 'register_first_step';
  static const String register = 'register';
  static const String movie = 'movie';
}

///用于main MaterialApp配置 onGenerateRoute
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.webView:
        var model = settings.arguments as WebViewModel;
        return MaterialPageRoute(
          builder: (context) => WebViewPage(model),
        );
      case RouteName.login:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case RouteName.register_first_step:
        var isRegister = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (context) => RegisterFirstStepPage(
                  isRegister: isRegister,
                ));
      case RouteName.movie:
        return MaterialPageRoute(
          builder: (context) => MoviePage(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
