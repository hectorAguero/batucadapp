import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/main_logger.dart';
import 'package:samba_public_app/main_providers.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    try {
      final mode =
          ref.watch(sharedPreferencesProvider).value!.getString('theme_mode');
      return switch (mode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' || (_) => ThemeMode.system,
      };
    } catch (e) {
      debugLog('$e');
      return ThemeMode.system;
    }
  }

  Future<void> toggleTheme() async {
    switch (state) {
      case ThemeMode.system:
        final prefs = ref.read(sharedPreferencesProvider).requireValue;
        await prefs.setString('theme_mode', 'light');
        ref
            .read(appThemeTrueBlackProvider.notifier)
            .toggleTrueBlack(forceState: false);
        state = ThemeMode.light;
      case ThemeMode.light:
        final prefs = ref.read(sharedPreferencesProvider).requireValue;
        await prefs.setString('theme_mode', 'dark');
        state = ThemeMode.dark;
      case ThemeMode.dark:
        final prefs = ref.read(sharedPreferencesProvider).requireValue;
        await prefs.remove('theme_mode');
        state = ThemeMode.system;
    }
  }

  void setTheme(ThemeMode mode) {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
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
      return ref
              .watch(sharedPreferencesProvider)
              .value!
              .getBool('true_black') ??
          false;
    } catch (e) {
      debugLog('$e');
      return false;
    }
  }

  void toggleTrueBlack({bool? forceState}) {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    state = forceState ?? !state;
    if (state) {
      prefs.setBool('true_black', state);
    } else {
      prefs.remove('true_black');
    }
  }
}
