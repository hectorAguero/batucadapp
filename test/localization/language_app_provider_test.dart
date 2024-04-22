import 'package:batucadapp/core/providers/prefs_provider.dart';
import 'package:batucadapp/localization/language.dart';
import 'package:batucadapp/localization/language_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../core/providers/prefs_provider_test.dart';

ProviderContainer makeProviderContainer(
  MockSharedPreferences? mockSharedPreferences,
) {
  final container = ProviderContainer(
    overrides: [
      if (mockSharedPreferences != null)
        prefsProvider.overrideWith((_) => mockSharedPreferences),
      languageAppProvider.overrideWith(LanguageApp.new),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  group('Build Language App Provider', () {
    test('Return default when SharedPreferences doesnt have a value', () async {
      final container = makeProviderContainer(MockSharedPreferences());
      final language = await container.read(languageAppProvider.future);
      expect(
        language.languageCode,
        TestWidgetsFlutterBinding
            .instance.platformDispatcher.locale.languageCode,
      );
    });

    test('Return default when SharedPreferences nor Flutter have a right value',
        () async {
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('und', '');
      final container = makeProviderContainer(MockSharedPreferences());
      final language = await container.read(languageAppProvider.future);
      expect(
        language.languageCode,
        'en',
      );
    });

    test('Return value from SharedPreferences', () async {
      final initialData = {
        'locale': Language.pt.languageCode,
      };
      final mockPrefs = MockSharedPreferences.setMockInitialValues(initialData);
      final container = makeProviderContainer(mockPrefs);
      final language = await container.read(languageAppProvider.future);
      expect(language, Language.pt);
    });
  });

  group('Set Language', () {
    test('Set custom language to SharedPreferences', () async {
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('en', '');
      final initialData = {'locale': Language.pt.languageCode};
      final mock = MockSharedPreferences.setMockInitialValues(initialData);
      when(() => mock.setString('locale', any())).thenAnswer((_) async => true);
      final container = makeProviderContainer(mock);
      final languageApp = container.read(languageAppProvider.notifier);
      await languageApp.setLanguage(Language.es);
      await expectLater(
        container.read(languageAppProvider.future),
        completion(Language.es),
      );
    });

    test('Set default platform language', () async {
      TestWidgetsFlutterBinding.instance.platformDispatcher.localeTestValue =
          const Locale('es', '');
      final initialData = {'locale': Language.pt.languageCode};
      final mock = MockSharedPreferences.setMockInitialValues(initialData);
      when(() => mock.remove('locale')).thenAnswer((_) async => true);
      final container = makeProviderContainer(mock);
      final languageApp = container.read(languageAppProvider.notifier);
      await languageApp.setLanguage(Language.es);
      await expectLater(
        container.read(languageAppProvider.future),
        completion(Language.es),
      );
    });
  });
}
