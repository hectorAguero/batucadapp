import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/shared_preferences_provider.dart';
import '../../extensions/app_localization_extension.dart';
import '../../extensions/intl_extension.dart';
import '../../utils/unmodifiable_list.dart';
import 'school.dart';
import 'school_extensions.dart';
import 'school_sort.dart';
import 'schools_repo.dart';
import 'widgets/school_card.dart';

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
  FutureOr<UnmodifiableList<School>> build() async {
    final schools = await ref.watch(schoolsRepoProvider).getSchools();
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    final favoriteSchools = prefs.getStringList('favoriteSchools') ?? [];
    return UnmodifiableList([
      for (final school in schools)
        if (favoriteSchools.contains('${school.id}'))
          school.copyWith(isFavorite: true)
        else
          school,
    ]);
  }

  Future<void> toggleFavorite(SchoolId id) async {
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    var favoriteSchools =
        UnmodifiableList(prefs.getStringList('favoriteSchools') ?? <String>[]);
    var schools = UnmodifiableList([...state.value!]);
    final index = schools.indexWhere((school) => school.id == id);

    if (index == -1) return;

    schools = UnmodifiableList([
      ...schools.sublist(0, index),
      schools[index].copyWith(isFavorite: !schools[index].isFavorite),
      ...schools.sublist(index + 1),
    ]);

    if (schools[index].isFavorite) {
      favoriteSchools =
          UnmodifiableList([...favoriteSchools, '${schools[index].id}']);
    } else {
      favoriteSchools = UnmodifiableList([
        for (final schoolId in favoriteSchools)
          if (schoolId != '${schools[index].id}') schoolId,
      ]);
    }
    await prefs.setStringList('favoriteSchools', favoriteSchools);
    state = AsyncData(schools);
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
  String getSortedValue(School school, BuildContext context) => switch (this) {
        (SchoolSort.lastPerformance) =>
          '${school.lastPosition}${context.loc.schoolPerformancePlace}',
        (SchoolSort.location) =>
          CountryLocalizations.of(context)!.countryName(countryCode: 'BR')!,
        _ => school.foundationDate.intlShort(context)
      };
}

@riverpod
class IsFavoriteSchools extends _$IsFavoriteSchools {
  @override
  bool build() {
    return false;
  }

  void toggleFavorite() {
    state = !state;
  }
}

final filteredSchoolsProvider =
    Provider.autoDispose<UnmodifiableList<School>>((ref) {
  final filter = ref.watch(schoolDivisionsProvider);
  final search = ref.watch(searchSchoolProvider);
  final schools = ref.watch(schoolsProvider);
  final sort = ref.watch(selectedSchoolSortProvider);
  final isNotFavorite = !ref.watch(isFavoriteSchoolsProvider);

  if (schools.value == null) return UnmodifiableList(const []);

  final filteredSchools = schools.value!
      .where(
        (school) =>
            (filter[school.currentDivision] ?? false) &&
            school.searchLogic(search) &&
            (isNotFavorite || school.isFavorite),
      )
      .toList()
    ..sort(sort.sortSwitch);

  return UnmodifiableList(filteredSchools);
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
