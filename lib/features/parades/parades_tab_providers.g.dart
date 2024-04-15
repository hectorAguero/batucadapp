// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parades_tab_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paradesHash() => r'c49a4e922bbd7721ea995b6fd49483dbffd81cea';

/// See also [Parades].
@ProviderFor(Parades)
final paradesProvider =
    AutoDisposeAsyncNotifierProvider<Parades, ImmutableList<Parade>>.internal(
  Parades.new,
  name: r'paradesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$paradesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Parades = AutoDisposeAsyncNotifier<ImmutableList<Parade>>;
String _$paradesTabReachedLimitHash() =>
    r'e24c9ae9f3318555dd548f146cde6bc7ff0fb670';

/// See also [ParadesTabReachedLimit].
@ProviderFor(ParadesTabReachedLimit)
final paradesTabReachedLimitProvider =
    AutoDisposeNotifierProvider<ParadesTabReachedLimit, bool>.internal(
  ParadesTabReachedLimit.new,
  name: r'paradesTabReachedLimitProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paradesTabReachedLimitHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ParadesTabReachedLimit = AutoDisposeNotifier<bool>;
String _$paradeShowOriginalHash() =>
    r'30860c76acf8688b5ef178bf3a21cb0dca1254cf';

/// See also [ParadeShowOriginal].
@ProviderFor(ParadeShowOriginal)
final paradeShowOriginalProvider =
    AutoDisposeNotifierProvider<ParadeShowOriginal, bool>.internal(
  ParadeShowOriginal.new,
  name: r'paradeShowOriginalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paradeShowOriginalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ParadeShowOriginal = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
