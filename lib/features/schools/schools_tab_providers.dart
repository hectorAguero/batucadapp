import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/shared_preferences_provider.dart';
import '../../utils/main_logger.dart';
import 'school.dart';
import 'school_extensions.dart';
import 'school_sort.dart';
import 'schools_repo.dart';
import 'widgets/school_card.dart';

part 'schools_tab_providers.g.dart';

@riverpod
class Schools extends _$Schools {
  static const _pageSize = 10;

  @override
  FutureOr<UnmodifiableListView<School>> build() async {
    return _getSchools();
  }

  Future<bool?> fetchNextPage({int pageSize = _pageSize}) async {
    try {
      final schools = await _getSchools(
        page: state.value!.length ~/ pageSize + 1,
        pageSize: pageSize,
      );
      if (schools.isNotEmpty) {
        state = AsyncData(UnmodifiableListView([...state.value!, ...schools]));
        return true;
      }
      return false;
    } catch (e, st) {
      viewLog.fine('Failed to fetch next page', e, st);
      return null;
    }
  }

  Future<UnmodifiableListView<School>> _getSchools({
    int page = 1,
    int pageSize = _pageSize,
  }) async {
    final schools = await ref.watch(schoolsRepoProvider).getSchools(
          page: page,
          pageSize: pageSize,
        );
    if (schools.isEmpty) {
      ref.read(schoolsTabReachedLimitProvider.notifier).setReachedLimit();
      return schools;
    }
    return schools;
  }
}

@riverpod
class FavoriteSchools extends _$FavoriteSchools {
  @override
  UnmodifiableListView<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    return UnmodifiableListView(prefs.getStringList('favoriteSchools') ?? []);
  }

  void toggleFavorite(SchoolId id) {
    final prefs = ref.watch(sharedPreferencesProvider).value!;
    final favoriteSchools = prefs.getStringList('favoriteSchools') ?? [];
    if (favoriteSchools.contains('$id')) {
      favoriteSchools.remove('$id');
    } else {
      favoriteSchools.add('$id');
    }
    prefs.setStringList('favoriteSchools', favoriteSchools);
    state = UnmodifiableListView(favoriteSchools);
  }

  bool isFavorite(SchoolId id) {
    final favoriteSchools = state;
    return favoriteSchools.contains('$id');
  }
}

@riverpod
class SchoolDivisions extends _$SchoolDivisions {
  @override
  Map<SchoolDivision, bool> build() {
    final schools = ref.watch(schoolsProvider).value;
    final divisions = schools?.map((e) => e.currentDivision).toSet() ?? {};
    return <SchoolDivision, bool>{
      for (final division in divisions) division: true,
    };
  }

  void selectDivision(SchoolDivision division) {
    state = {...state, division: true};
  }

  void removeDivision(SchoolDivision division) =>
      state = {...state, division: false};

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
class SearchSchool extends _$SearchSchool {
  @override
  String build() => '';

  void setSearch(String value) => state = value.trim().toLowerCase();
}

@riverpod
class SelectedSchoolSort extends _$SelectedSchoolSort {
  @override
  SchoolSort build() => SchoolSort.lastPerformance;

  void setSort(SchoolSort sort) => state = sort;
}

@riverpod
class ShowOnlyFavoriteSchools extends _$ShowOnlyFavoriteSchools {
  @override
  bool build() => false;

  void turnOffShowFavorites() => state = false;

  void turnOnShowFavorites() => state = true;

  void toggleShowFavorites() {
    state = !state;
    if (state) ref.read(schoolDivisionsProvider.notifier).selectAll();
  }
}

final filteredSchoolsProvider =
    Provider.autoDispose<UnmodifiableListView<School>>((ref) {
  final filter = ref.watch(schoolDivisionsProvider);
  final search = ref.watch(searchSchoolProvider);
  final schools = ref.watch(schoolsProvider);
  final favoritesIds = ref.watch(favoriteSchoolsProvider);
  final sort = ref.watch(selectedSchoolSortProvider);
  final onlyFavorites = ref.watch(showOnlyFavoriteSchoolsProvider);

  if (schools.value == null) return UnmodifiableListView([]);

  final filteredSchools = schools.value!
      .where(
        (school) =>
            (filter[school.currentDivision] ?? false) &&
            school.searchLogic(search) &&
            (!onlyFavorites || favoritesIds.contains('${school.id}')),
      )
      .toList()
    ..sort(sort.sortSwitch);

  return UnmodifiableListView(filteredSchools);
});

@riverpod
class SchoolsTabReachedLimit extends _$SchoolsTabReachedLimit {
  @override
  bool build() => false;

  void setReachedLimit() => state = true;

  void resetReachedLimit() => state = false;
}

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
