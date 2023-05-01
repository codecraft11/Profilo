import 'package:flutter/material.dart';

class AppThemes {
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        color: colorScheme.primary,
        elevation: 0,
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }

  static final ColorScheme darkColorScheme = ColorScheme(
    primary: Colors.lightBlue,
    primaryVariant: Colors.lightBlue.shade900,
    secondary: Colors.yellow,
    secondaryVariant: Colors.yellow.shade900,
    background: const Color(0xff141A31),
    surface: const Color(0xff1E2746),
    onBackground: const Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
