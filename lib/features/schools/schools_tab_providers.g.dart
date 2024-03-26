// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schools_tab_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schoolDivisionsHash() => r'f6d237814451cdcc436abdf44ca0fd012c8b394d';

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
String _$searchSchoolHash() => r'd85db3c9f9b14546084048cf1169bc7f1f8ab2e3';

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
    r'892bdd7bfc490da6b4288e56d8038d9998fc3425';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
