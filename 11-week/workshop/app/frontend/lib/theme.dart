import 'package:flutter/material.dart';

abstract final class AppTokens {
  static const Color primary = Color(0xff8a2942);
  static const Color secondary = Color(0xff5b3a00);
  static const Color success = Color(0xff1b6b3a);
  static const Color error = Color(0xffb3261e);
  static const Color background = Color(0xfffff8f5);
  static const Color surface = Colors.white;
  static const Color text = Color(0xff231f20);
  static const Color mutedText = Color(0xff5f5a5c);

  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;

  static const double textSm = 14;
  static const double textMd = 16;
  static const double textLg = 22;
  static const double textXl = 30;
  static const double minTouchTarget = 48;
}

ThemeData buildAppTheme() {
  const colors = ColorScheme.light(
    primary: AppTokens.primary,
    onPrimary: Colors.white,
    secondary: AppTokens.secondary,
    onSecondary: Colors.white,
    error: AppTokens.error,
    onError: Colors.white,
    surface: AppTokens.background,
    onSurface: AppTokens.text,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colors,
    scaffoldBackgroundColor: AppTokens.background,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: AppTokens.textXl,
        fontWeight: FontWeight.w900,
      ),
      titleLarge: TextStyle(
        fontSize: AppTokens.textLg,
        fontWeight: FontWeight.w800,
      ),
      bodyLarge: TextStyle(fontSize: AppTokens.textMd),
      bodyMedium: TextStyle(fontSize: AppTokens.textSm),
      labelLarge: TextStyle(
        fontSize: AppTokens.textSm,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTokens.background,
      foregroundColor: AppTokens.text,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTokens.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppTokens.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: AppTokens.surface,
      indicatorColor: Color(0xfff5d5dd),
      height: 72,
    ),
  );
}
