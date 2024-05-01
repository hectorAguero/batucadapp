// ignore_for_file: avoid_non_null_assertion
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_localization_extension.dart';

extension ThemeOfContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Brightness get brightness => theme.brightness;
  bool get brightnessIsDark => brightness == Brightness.dark;
  bool get brightnessIsLight => brightness == Brightness.light;

  ColorScheme get colorScheme => theme.colorScheme;

  // TextStyles non nullables https://github.com/flutter/flutter/issues/86807
  TextTheme get textTheme => theme.textTheme;
  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;

  // Custom colors non nullables https://github.com/flutter/flutter/issues/75695
  AppCustomColors get customColors => theme.extension<AppCustomColors>()!;
  Color get customTextColor => customColors.textColor!;
  Color get customInverseTextColor => customColors.inverseTextColor!;
  Color get customGoldColor => customColors.goldColor!;
  Color get customSilverColor => customColors.silverColor!;
  Color get customBronzeColor => customColors.bronzeColor!;
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
