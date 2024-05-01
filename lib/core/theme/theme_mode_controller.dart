import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/app_loggers.dart';
import '../providers/prefs.dart';

part 'theme_mode_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    try {
      final prefs = ref.watch(prefsProvider).value;
      final mode = prefs?.getString('theme_mode');

      return switch (mode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        (_) => ThemeMode.system,
      };
    } catch (e) {
      logViews.finest('$e');

      return ThemeMode.system;
    }
  }

  Future<void> toggleTheme() async {
    switch (state) {
      case ThemeMode.system:
        final prefs = ref.read(prefsProvider).requireValue;
        await prefs.setString('theme_mode', 'light');
        ref
            .read(appThemeTrueBlackProvider.notifier)
            .toggleTrueBlack(forceState: false);
        state = ThemeMode.light;
      case ThemeMode.light:
        final prefs = ref.read(prefsProvider).requireValue;
        await prefs.setString('theme_mode', 'dark');
        state = ThemeMode.dark;
      case ThemeMode.dark:
        final prefs = ref.read(prefsProvider).requireValue;
        await prefs.remove('theme_mode');
        state = ThemeMode.system;
    }
  }

  void setTheme(ThemeMode mode) {
    final prefs = ref.read(prefsProvider).requireValue;
    switch (mode) {
      case ThemeMode.system:
        prefs.remove('theme_mode');
        state = ThemeMode.system;
      case ThemeMode.light:
        prefs.setString('theme_mode', 'light');
        state = ThemeMode.light;
      case ThemeMode.dark:
        prefs.setString('theme_mode', 'dark');
        state = ThemeMode.dark;
    }
  }
}

@riverpod
class AppThemeTrueBlack extends _$AppThemeTrueBlack {
  @override
  bool build() {
    try {
      return ref.watch(prefsProvider).requireValue.getBool('true_black') ??
          false;
    } catch (e) {
      logViews.finest('$e');

      return false;
    }
  }

  void toggleTrueBlack({bool? forceState}) {
    final prefs = ref.read(prefsProvider).requireValue;
    state = forceState ?? !state;
    if (state) {
      prefs.setBool('true_black', state);
    } else {
      prefs.remove('true_black');
    }
  }
}
