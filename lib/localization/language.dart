import 'dart:ui';

enum Language {
  en,
  es,
  pt,
  ja;
}

extension LanguageExtension on Language {
  Locale get locale => switch (this) {
        Language.en => const Locale('en', ''),
        Language.es => const Locale('es', ''),
        Language.pt => const Locale('pt', ''),
        Language.ja => const Locale('ja', '')
      };

  String get languageCode => switch (this) {
        Language.en => 'en',
        Language.es => 'es',
        Language.pt => 'pt',
        Language.ja => 'ja'
      };
}

extension LocaleExtension on Locale {
  Language get languageApp => switch (languageCode) {
        'en' => Language.en,
        'es' => Language.es,
        'pt' => Language.pt,
        'ja' => Language.ja,
        _ => Language.en,
      };
}
