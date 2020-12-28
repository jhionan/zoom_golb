import 'package:flutter/material.dart';
import 'package:zoom_golb/features/auth/view/login.dart';
import 'package:zoom_golb/features/feed/view/feed.dart';

import 'package:zoom_golb/features/splash/view/splash.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String feed = '/feed';
  static Route<Object> onGenerateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case home:
        page = Splash();
        break;
      case login:
        page = Login();
        break;
      case feed:
        page = Feed();
        break;
    }
    return MaterialPageRoute(builder: (context) => page);
  }
}
