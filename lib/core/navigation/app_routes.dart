import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String feed = '/feed';
  static Route<Object> onGenerateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case home:
    }
    return MaterialPageRoute(builder: (context) => page);
  }
}
