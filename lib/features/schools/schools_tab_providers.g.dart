// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_tab_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schoolsHash() => r'e12ffc302be33a1b36ca478230ec446528e969ca';

/// See also [Schools].
@ProviderFor(Schools)
final schoolsProvider =
    AutoDisposeAsyncNotifierProvider<Schools, ImmutableList<School>>.internal(
  Schools.new,
  name: r'schoolsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$schoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Schools = AutoDisposeAsyncNotifier<ImmutableList<School>>;
String _$favoriteSchoolsHash() => r'2734a25c2df1d78c93a6853617a63d8f0d28f1a3';

/// See also [FavoriteSchools].
@ProviderFor(FavoriteSchools)
final favoriteSchoolsProvider = AutoDisposeNotifierProvider<FavoriteSchools,
    ImmutableList<String>>.internal(
  FavoriteSchools.new,
  name: r'favoriteSchoolsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteSchoolsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteSchools = AutoDisposeNotifier<ImmutableList<String>>;
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
String _$searchedSchoolHash() => r'892b70063c17605607db413c3ffabd975d2897be';

/// See also [SearchedSchool].
@ProviderFor(SearchedSchool)
final searchedSchoolProvider =
    AutoDisposeNotifierProvider<SearchedSchool, String>.internal(
  SearchedSchool.new,
  name: r'searchedSchoolProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchedSchoolHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchedSchool = AutoDisposeNotifier<String>;
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
String _$schoolReachedMaxHash() => r'40829c21f39aa3352ab246f1521c44c426153a0c';

/// See also [SchoolReachedMax].
@ProviderFor(SchoolReachedMax)
final schoolReachedMaxProvider =
    AutoDisposeNotifierProvider<SchoolReachedMax, bool>.internal(
  SchoolReachedMax.new,
  name: r'schoolReachedMaxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schoolReachedMaxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SchoolReachedMax = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
