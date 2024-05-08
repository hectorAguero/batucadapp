// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initialLocationHash() => r'4c7394612af5559b8ca199b5410a10f3356021cf';

/// See also [initialLocation].
@ProviderFor(initialLocation)
final initialLocationProvider = AutoDisposeFutureProvider<String?>.internal(
  initialLocation,
  name: r'initialLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initialLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InitialLocationRef = AutoDisposeFutureProviderRef<String?>;
String _$appRouterHash() => r'f9fdd4f7f1c3ccc126de96231254893c15fc3252';

/// See also [AppRouter].
@ProviderFor(AppRouter)
final appRouterProvider =
    AutoDisposeNotifierProvider<AppRouter, GoRouter>.internal(
  AppRouter.new,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppRouter = AutoDisposeNotifier<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
