// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'7edfc6ee72a4a68cd2ba501aaa48afbd77ce740e';

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
String _$appThemeTrueBlackHash() => r'88d37a11dd13487f21c64baf3a1873046a861ca4';

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
