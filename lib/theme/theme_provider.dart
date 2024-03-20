import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.system:
        state = ThemeMode.light;
      case ThemeMode.light:
        state = ThemeMode.dark;
      case ThemeMode.dark:
        state = ThemeMode.system;
    }
  }
}

@riverpod
class AppThemeTrueBlack extends _$AppThemeTrueBlack {
  @override
  bool build() {
    return false;
  }

  void toggleTrueBlack() {
    state = !state;
  }
}
