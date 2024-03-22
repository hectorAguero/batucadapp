// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_tab_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedDivisionsHash() => r'934311f99c0814f935ec2ce9cd2c4b66f3615bdc';

/// See also [SelectedDivisions].
@ProviderFor(SelectedDivisions)
final selectedDivisionsProvider = AutoDisposeNotifierProvider<SelectedDivisions,
    Map<SchoolDivision, bool>>.internal(
  SelectedDivisions.new,
  name: r'selectedDivisionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDivisionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDivisions = AutoDisposeNotifier<Map<SchoolDivision, bool>>;
String _$schoolsHash() => r'de570650ab1154f1fa90196141b4512233265df9';

/// See also [Schools].
@ProviderFor(Schools)
final schoolsProvider =
    AutoDisposeAsyncNotifierProvider<Schools, List<School>>.internal(
  Schools.new,
  name: r'schoolsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$schoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Schools = AutoDisposeAsyncNotifier<List<School>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
