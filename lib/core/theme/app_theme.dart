import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema terang & gelap (bonus: dual-theme). Font kustom: Poppins.
class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Poppins';

  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}
