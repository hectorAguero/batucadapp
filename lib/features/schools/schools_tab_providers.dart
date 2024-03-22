import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/schools_repo.dart';

part 'schools_tab_providers.g.dart';

@riverpod
class SelectedDivisions extends _$SelectedDivisions {
  @override
  Map<SchoolDivision, bool> build() {
    return <SchoolDivision, bool>{
      for (final division in SchoolDivision.values) division: true,
    };
  }

  void selectDivision(SchoolDivision division) {
    state = {...state, division: true};
  }

  void removeDivision(SchoolDivision division) {
    state = {...state, division: false};
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

  List<int> getSchooldIds() {
    return state.requireValue.map((e) => e.id).toList();
  }
}

@riverpod
class FilteredSchools extends _$FilteredSchools {
  @override
  FutureOr<List<School>> build() async {
    final schools = await ref.watch(schoolsProvider.future);
    final filter = ref.watch(selectedDivisionsProvider);
    return schools
        .where((school) => filter[school.currentDivision] ?? false)
        .toList();
  }
}
