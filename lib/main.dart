import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
          child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
