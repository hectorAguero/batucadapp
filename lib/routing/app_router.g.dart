// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initialLocationHash() => r'ccb27e336cb1858587eaf1b2ab2365c484b9a2c5';

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
String _$appRouterHash() => r'76ee8b423fd5558a0ccb6682c9476bab47e76b8c';

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
