// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'5ff640e12db50254df0062f20c5f89515110a2fd';

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
String _$appThemeTrueBlackHash() => r'96a75eb949009fb873ec287ba8a93084103f870a';

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
