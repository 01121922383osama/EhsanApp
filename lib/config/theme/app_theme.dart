import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBlue,
    ),
    scaffoldBackgroundColor: AppColors.white,
    useMaterial3: true,
  );
}
