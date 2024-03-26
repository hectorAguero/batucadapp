import 'dart:ui';

import 'package:samba_public_app/extensions/hardcoded_extension.dart';

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

  String get name => switch (this) {
        Language.en => 'English'.hardcoded,
        Language.es => 'Spanish'.hardcoded,
        Language.pt => 'Portuguese'.hardcoded,
        Language.ja => 'Japanese'.hardcoded
      };

  String get nativeName => switch (this) {
        Language.en => 'English'.hardcoded,
        Language.es => 'Español'.hardcoded,
        Language.pt => 'Português'.hardcoded,
        Language.ja => '日本語'.hardcoded
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
