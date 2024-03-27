import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';

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

  String name(BuildContext context) => switch (this) {
        Language.en => context.loc.english,
        Language.es => context.loc.spanish,
        Language.pt => context.loc.portuguese,
        Language.ja => context.loc.japanese
      };

  String get nativeName => switch (this) {
        Language.en => 'English',
        Language.es => 'Español',
        Language.pt => 'Português',
        Language.ja => '日本語'
      };

  String get languageCode => switch (this) {
        Language.en => 'en',
        Language.es => 'es',
        Language.pt => 'pt',
        Language.ja => 'ja'
      };

  String get languageCountryCode => switch (this) {
        Language.en => 'en_US',
        Language.es => 'es_ES',
        Language.pt => 'pt_BR',
        Language.ja => 'ja_JP'
      };

  bool get isSameAsPlatform {
    final platformLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return languageCode == platformLanguage;
  }
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
