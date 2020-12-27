import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';
import 'package:zoom_golb/core/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
