import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/start/login_page.dart';
import 'package:flutter_learn/module/start/register_first_step_page.dart';
import 'package:flutter_learn/module/web_view_page.dart';

class RouteName {
  static const String webView = 'webView';
  static const String login = 'login';
  static const String register_first_step = 'register_first_step';
  static const String register = 'register';
}

///用于main MaterialApp配置 onGenerateRoute
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.webView:
        var model = settings.arguments as WebViewModel;
        return MaterialPageRoute(builder: (_) => WebViewPage(model));
      case RouteName.login:
        return MaterialPageRoute(
            fullscreenDialog: false, builder: (_) => LoginPage());
      case RouteName.register_first_step:
        var isRegister = settings.arguments as bool;
        return MaterialPageRoute(
            fullscreenDialog: false,
            builder: (_) => RegisterFirstStepPage(
                  isRegister: isRegister,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
