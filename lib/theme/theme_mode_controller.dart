import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/providers/prefs.dart';
import '../utils/app_loggers.dart';

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

@riverpod
class AppSelectedColors extends _$AppSelectedColors {
  @override
  AppColors build() {
    return AppColors.defaultColors();
  }

  void setColors(AppColors colors) {
    final luminance = colors.primary.computeLuminance();
    const percentage = 30;
    Color primary = colors.primary;
    if (luminance == 0) {
      primary = primary.lighten(percentage);
    } else if (luminance == 1) {
      primary = primary.darken(percentage);
    }

    state = AppColors(
      primary: primary,
      secondary: colors.secondary,
      tertiary: colors.tertiary,
    );
  }
}

class AppColors {
  final Color primary;
  final Color? secondary;
  final Color? tertiary;

  AppColors({
    required this.primary,
    this.secondary,
    this.tertiary,
  });

  AppColors.defaultColors()
      : primary = const Color(0xffff00a5),
        secondary = const Color(0xff00a859),
        tertiary = null;

  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
    );
  }

  // ignore: member_ordering
  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ tertiary.hashCode;

  @override
  bool operator ==(covariant AppColors other) {
    return primary == other.primary &&
        secondary == other.secondary &&
        tertiary == other.tertiary;
  }

  @override
  String toString() {
    return 'AppColors{primary: $primary, '
        'secondary: $secondary, tertiary: $tertiary}';
  }
}

extension AppColorsExtension on AppColors {
  int get usedColors {
    return (secondary != null ? 1 : 0) + (tertiary != null ? 1 : 0) + 1;
  }
}
