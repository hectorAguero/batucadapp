import 'package:flutter/material.dart';

extension TextThemeOfContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.of(this).brightness;
  bool get brightnessIsDark => brightness == Brightness.dark;
  bool get brightnessIsLight => brightness == Brightness.light;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension ThemeModeExtension on ThemeMode {
  String get name => switch (this) {
        ThemeMode.system => 'System Theme',
        ThemeMode.light => 'Light Theme',
        ThemeMode.dark => 'Dark Theme'
      };

  IconData get icon => switch (this) {
        ThemeMode.system => Icons.brightness_medium,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode
      };

  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
  bool get isSystem => this == ThemeMode.system;
}
