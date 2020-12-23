import 'package:flutter/material.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.primary,
      accentColor: AppColors.accent,
      secondaryHeaderColor: AppColors.secundary,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ));
}
