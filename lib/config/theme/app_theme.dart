import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBlue,
    ),
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: AppString.fonFamily,
    useMaterial3: true,
  );
}
