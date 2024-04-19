import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/providers/prefs_provider.dart';
import 'language.dart';

part 'language_app_provider.g.dart';

@Riverpod(keepAlive: true)
class LanguageApp extends _$LanguageApp {
  @override
  FutureOr<Language?> build() async {
    final prefs = await ref.watch(prefsProvider.future);
    final localeKey = prefs.getString('locale') ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return Language.values.firstWhere((e) => e.languageCode == localeKey);
  }

  Future<void> setLanguage(
    Language language,
  ) async {
    final prefs = ref.read(prefsProvider).value;
    if (language.isSameAsPlatform) {
      await prefs!.remove('locale');
    } else {
      await prefs!.setString('locale', language.languageCode);
    }
    state = AsyncData(language);
  }
}
