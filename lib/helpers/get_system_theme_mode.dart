import 'package:flutter/material.dart';

class ThemeModeHelper {
  static ThemeMode getSystemThemeMode(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}
