// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_tab_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schoolsHash() => r'6cd2e21401e3e7d302caa2fcc52f87c1e4ff135d';

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
String _$favoriteSchoolsHash() => r'f003884370854f60456cbbba3aca2fdcf93d03c9';

/// See also [FavoriteSchools].
@ProviderFor(FavoriteSchools)
final favoriteSchoolsProvider =
    AutoDisposeNotifierProvider<FavoriteSchools, List<String>>.internal(
  FavoriteSchools.new,
  name: r'favoriteSchoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteSchoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteSchools = AutoDisposeNotifier<List<String>>;
String _$schoolDivisionsHash() => r'790ca8cc34132ada189c3bdfaa8f3e68046700f0';

/// See also [SchoolDivisions].
@ProviderFor(SchoolDivisions)
final schoolDivisionsProvider = AutoDisposeNotifierProvider<SchoolDivisions,
    Map<SchoolDivision, bool>>.internal(
  SchoolDivisions.new,
  name: r'schoolDivisionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schoolDivisionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SchoolDivisions = AutoDisposeNotifier<Map<SchoolDivision, bool>>;
String _$searchSchoolHash() => r'310d82c631ee6cf916fcd231fde0787ea4a321ac';

/// See also [SearchSchool].
@ProviderFor(SearchSchool)
final searchSchoolProvider =
    AutoDisposeNotifierProvider<SearchSchool, String>.internal(
  SearchSchool.new,
  name: r'searchSchoolProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchSchoolHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchSchool = AutoDisposeNotifier<String>;
String _$selectedSchoolSortHash() =>
    r'86e1946a159f33cff5fb8ebc460ef8327a9f6a4c';

/// See also [SelectedSchoolSort].
@ProviderFor(SelectedSchoolSort)
final selectedSchoolSortProvider =
    AutoDisposeNotifierProvider<SelectedSchoolSort, SchoolSort>.internal(
  SelectedSchoolSort.new,
  name: r'selectedSchoolSortProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSchoolSortHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSchoolSort = AutoDisposeNotifier<SchoolSort>;
String _$showOnlyFavoriteSchoolsHash() =>
    r'26e2b8170f0bfa9136520d2d106cedd8bdb81af8';

/// See also [ShowOnlyFavoriteSchools].
@ProviderFor(ShowOnlyFavoriteSchools)
final showOnlyFavoriteSchoolsProvider =
    AutoDisposeNotifierProvider<ShowOnlyFavoriteSchools, bool>.internal(
  ShowOnlyFavoriteSchools.new,
  name: r'showOnlyFavoriteSchoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showOnlyFavoriteSchoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowOnlyFavoriteSchools = AutoDisposeNotifier<bool>;
String _$schoolsTabReachedLimitHash() =>
    r'a59f253dfd36fa285e5f1e0157f51181e9169206';

/// See also [SchoolsTabReachedLimit].
@ProviderFor(SchoolsTabReachedLimit)
final schoolsTabReachedLimitProvider =
    AutoDisposeNotifierProvider<SchoolsTabReachedLimit, bool>.internal(
  SchoolsTabReachedLimit.new,
  name: r'schoolsTabReachedLimitProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schoolsTabReachedLimitHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SchoolsTabReachedLimit = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
