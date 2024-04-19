import 'package:batucadapp/core/providers/prefs_provider.dart';
import 'package:batucadapp/localization/language.dart';
import 'package:batucadapp/localization/language_app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/providers/prefs_provider_test.dart';
import '../create_container.dart';

ProviderContainer setupAppThemeModeProvider(
  MockSharedPreferences? mockSharedPreferences,
) =>
    createContainer(
      overrides: [
        if (mockSharedPreferences != null)
          prefsProvider.overrideWith((_) => mockSharedPreferences),
        languageAppProvider.overrideWith(LanguageApp.new),
      ],
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Return default when SharedPreferences doesnt have a value', () async {
    final container = setupAppThemeModeProvider(MockSharedPreferences());
    final language = await container.read(languageAppProvider.future);
    expect(
      language?.languageCode,
      TestWidgetsFlutterBinding.instance.platformDispatcher.locale.languageCode,
    );
  });

  test('Return value from SharedPreferences', () async {
    final initialData = {
      'locale': Language.pt.languageCode,
    };
    final mockPrefs = MockSharedPreferences.setMockInitialValues(initialData);
    final container = setupAppThemeModeProvider(mockPrefs);
    final language = await container.read(languageAppProvider.future);
    expect(language, Language.pt);
  });
}
