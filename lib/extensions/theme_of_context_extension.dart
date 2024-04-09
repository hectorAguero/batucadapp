import 'package:flutter/material.dart';

import '../theme/theme_data.dart';
import 'app_localization_extension.dart';

extension TextThemeOfContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.of(this).brightness;
  bool get brightnessIsDark => brightness == Brightness.dark;
  bool get brightnessIsLight => brightness == Brightness.light;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  AppCustomColors get customColors =>
      Theme.of(this).extension<AppCustomColors>()!;

  Color medalColor(int placing) {
    return switch (placing) {
      1 => customColors.goldColor!,
      2 => customColors.silverColor!,
      _ => colorScheme.secondaryContainer,
    };
  }
}

extension ThemeModeExtension on ThemeMode {
  String label(BuildContext context) => switch (this) {
        ThemeMode.system => context.loc.system,
        ThemeMode.light => context.loc.light,
        ThemeMode.dark => context.loc.dark
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
