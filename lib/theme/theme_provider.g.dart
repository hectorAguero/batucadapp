// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'a54de50b73abe2ec0b0f9546c5d178c063e9b373';

/// See also [AppThemeMode].
@ProviderFor(AppThemeMode)
final appThemeModeProvider = NotifierProvider<AppThemeMode, ThemeMode>.internal(
  AppThemeMode.new,
  name: r'appThemeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppThemeMode = Notifier<ThemeMode>;
String _$appThemeTrueBlackHash() => r'e3ab2ff795559fd2253112014f342f3ded3088be';

/// See also [AppThemeTrueBlack].
@ProviderFor(AppThemeTrueBlack)
final appThemeTrueBlackProvider =
    AutoDisposeNotifierProvider<AppThemeTrueBlack, bool>.internal(
  AppThemeTrueBlack.new,
  name: r'appThemeTrueBlackProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appThemeTrueBlackHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppThemeTrueBlack = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
