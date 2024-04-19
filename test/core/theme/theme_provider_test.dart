import 'package:batucadapp/core/providers/prefs_provider.dart';
import 'package:batucadapp/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../create_container.dart';
import '../providers/prefs_provider_test.dart';

ProviderContainer setupAppThemeModeProvider(
  MockSharedPreferences? mockSharedPreferences,
) {
  return createContainer(
    overrides: [
      if (mockSharedPreferences != null)
        prefsProvider.overrideWith((_) => mockSharedPreferences),
      appThemeModeProvider.overrideWith(AppThemeMode.new),
    ],
  );
}

void main() {
  group('appThemeTrueBlackProvider tests', () {
    test('Return false when SharedPreferences doesnt have a value', () {
      final container = setupAppThemeModeProvider(null);
      final trueBlack = container.read(appThemeTrueBlackProvider);
      expect(trueBlack, false);
    });

    test('Return true when SharedPreferences has a value', () {
      final initialValues = {'true_black': true};
      final mock = MockSharedPreferences.setMockInitialValues(initialValues);
      final container = setupAppThemeModeProvider(mock);
      final trueBlack = container.read(appThemeTrueBlackProvider);
      expect(trueBlack, true);
    });

    test('Toggle trueBlack to true', () {
      final mock = MockSharedPreferences();
      when(() => mock.setBool('true_black', true))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mock);
      container.read(appThemeTrueBlackProvider.notifier).toggleTrueBlack();
      verify(() => mock.setBool('true_black', true)).called(1);
      expect(container.read(appThemeTrueBlackProvider), true);
    });

    test('Toggle trueBlack to false', () {
      final values = {'true_black': true};
      final mock = MockSharedPreferences.setMockInitialValues(values);
      final container = setupAppThemeModeProvider(mock);
      container.read(appThemeTrueBlackProvider.notifier).toggleTrueBlack();
      expect(container.read(appThemeTrueBlackProvider), false);
    });
  });

  group('Test the build of the appThemeProvider', () {
    test(' ThemeMode.system when SharedPreferences has no value', () async {
      final mockSharedPreferences = MockSharedPreferences();
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      final themeMode = container.read(appThemeModeProvider);
      expect(themeMode, ThemeMode.system);
    });

    test(' ThemeMode.system when SharedPreferences is not init', () async {
      final container = setupAppThemeModeProvider(null);
      final themeMode = container.read(appThemeModeProvider);
      expect(themeMode, ThemeMode.system);
    });

    test(' ThemeMode.light when SharedPreferences has value light', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.getString('theme_mode'))
          .thenReturn('light');
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      final themeMode = container.read(appThemeModeProvider);
      expect(themeMode, ThemeMode.light);
    });

    test(' ThemeMode.dark when SharedPreferences has value dark', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.getString('theme_mode'))
          .thenReturn('dark');
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      final themeMode = container.read(appThemeModeProvider);
      expect(themeMode, ThemeMode.dark);
    });
  });

  group('Test the setTheme function of appThemeProvider ', () {
    test('Set ThemeMode.system', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.remove('theme_mode'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      expect(container.read(appThemeModeProvider), ThemeMode.system);
      container.read(appThemeModeProvider.notifier).setTheme(ThemeMode.system);
      verify(() => mockSharedPreferences.remove('theme_mode')).called(1);
      expect(container.read(appThemeModeProvider), ThemeMode.system);
    });

    test('Set ThemeMode.light', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.setString('theme_mode', 'light'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      container.read(appThemeModeProvider.notifier).setTheme(ThemeMode.light);
      verify(() => mockSharedPreferences.setString('theme_mode', 'light'))
          .called(1);
      expect(container.read(appThemeModeProvider), ThemeMode.light);
    });

    test('Set ThemeMode.dark', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.setString('theme_mode', 'dark'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      container.read(appThemeModeProvider.notifier).setTheme(ThemeMode.dark);
      verify(() => mockSharedPreferences.setString('theme_mode', 'dark'))
          .called(1);
      expect(container.read(appThemeModeProvider), ThemeMode.dark);
    });
  });

  group('Apptheme toggleTheme tests', () {
    test('Toggle theme from ThemeMode.system', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.setString('theme_mode', 'light'))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.remove('true_black'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      await container.read(appThemeModeProvider.notifier).toggleTheme();
      expect(container.read(appThemeModeProvider), ThemeMode.light);
    });

    test('Toggle theme from ThemeMode.light', () async {
      final initialValue = {'theme_mode': 'light'};
      final mockSharedPreferences =
          MockSharedPreferences.setMockInitialValues(initialValue);
      when(() => mockSharedPreferences.setString('theme_mode', 'dark'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      await container.read(appThemeModeProvider.notifier).toggleTheme();
      expect(container.read(appThemeModeProvider), ThemeMode.dark);
    });

    test('Toggle theme from ThemeMode.dark', () async {
      final initialValue = {'theme_mode': 'dark'};
      final mockSharedPreferences =
          MockSharedPreferences.setMockInitialValues(initialValue);
      when(() => mockSharedPreferences.remove('theme_mode'))
          .thenAnswer((_) async => true);
      final container = setupAppThemeModeProvider(mockSharedPreferences);
      await container.read(appThemeModeProvider.notifier).toggleTheme();
      expect(container.read(appThemeModeProvider), ThemeMode.system);
    });
  });
}
