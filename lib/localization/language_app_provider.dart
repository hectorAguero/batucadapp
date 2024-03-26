import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/main_providers.dart';

part 'language_app_provider.g.dart';

@riverpod
class LanguageApp extends _$LanguageApp {
  @override
  FutureOr<Language?> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final localeKey = prefs.getString('locale');
    return Language.values.firstWhere(
      (e) => e.languageCode == localeKey,
    );
  }

  Future<void> setLanguage(Language language) async {
    final prefs = ref.read(sharedPreferencesProvider).value!;
    await prefs.setString('locale', language.languageCode);
    state = AsyncData(language);
  }
}
