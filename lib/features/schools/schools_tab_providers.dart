import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/extensions/intl_extension.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/school_sort.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/schools_repo.dart';
import 'package:samba_public_app/features/schools/widgets/school_card.dart';

part 'schools_tab_providers.g.dart';

@riverpod
class SchoolDivisions extends _$SchoolDivisions {
  @override
  Map<SchoolDivision, bool> build() {
    final divisions = ref
            .watch(schoolsProvider)
            .value
            ?.map((e) => e.currentDivision)
            .toSet() ??
        {};
    return <SchoolDivision, bool>{
      for (final division in divisions) division: true,
    };
  }

  void selectDivision(SchoolDivision division) {
    state = {...state, division: true};
  }

  void removeDivision(SchoolDivision division) {
    state = {...state, division: false};
  }

  void removeAll() {
    state = <SchoolDivision, bool>{
      for (final division in state.keys) division: false,
    };
  }

  void selectAll() {
    state = <SchoolDivision, bool>{
      for (final division in state.keys) division: true,
    };
  }
}

@riverpod
class Schools extends _$Schools {
  @override
  FutureOr<List<School>> build() async {
    final schools = await ref.watch(schoolsRepoProvider).getSchools();
    return schools;
  }

  void toggleFavorite(SchoolId id) {
    // Find the index of the school to update
    final index = state.requireValue.indexWhere((s) => s.id == id);
    if (index != -1) {
      final updatedSchools = List<School>.from(state.requireValue);

      updatedSchools[index] = updatedSchools[index].copyWith(
        isFavorite: !updatedSchools[index].isFavorite,
      );

      state = AsyncData(updatedSchools);
    }
  }
}

@riverpod
class SearchSchool extends _$SearchSchool {
  @override
  String build() {
    return '';
  }

  void setSearch(String value) {
    state = value.trim().toLowerCase();
  }
}

@riverpod
class SelectedSchoolSort extends _$SelectedSchoolSort {
  @override
  SchoolSort build() {
    return SchoolSort.lastPerformance;
  }

  void setSort(SchoolSort sort) {
    state = sort;
  }
}

extension SelectedSchoolSortExtension on SchoolSort {
  String getSortedValue(School school) =>
      switch (this) { _ => school.foundationDate.intlShort };
}

final filteredSchoolsProvider = Provider.autoDispose<List<School>>((ref) {
  final filter = ref.watch(schoolDivisionsProvider);
  final search = ref.watch(searchSchoolProvider);
  final schools = ref.watch(schoolsProvider);
  final sort = ref.watch(selectedSchoolSortProvider);

  if (schools.value == null) return const [];

  final filteredSchools = schools.value!
      .where(
        (school) =>
            (filter[school.currentDivision] ?? false) &&
            school.searchLogic(search),
      )
      .toList()
    ..sort(sort.sort);

  return filteredSchools;
});

/// A provider which exposes the [School] displayed by a [SchoolCard].
///
/// By retrieving the [School] through a provider instead of through its
/// constructor, this allows [SchoolCard] to be instantiated using the `const`
/// keyword.
///
/// This ensures that when we add/remove/edit schools, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
final currentSchoolProvider =
    Provider<School>((ref) => throw UnimplementedError());
