// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'429f7a40d1df8304a535214708cfb66f66f08773';

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
String _$appThemeTrueBlackHash() => r'c71eaecafef02c241b4e8c996cde320440828fe2';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
