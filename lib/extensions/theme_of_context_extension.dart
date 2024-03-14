import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension TextThemeOfContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.of(this).brightness;
  bool get isDark => brightness == Brightness.dark;
  bool get isLight => brightness == Brightness.light;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
