import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/schools_repo.dart';
import 'package:samba_public_app/features/schools/widgets/school_card.dart';

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
}

final filteredSchoolsProvider = Provider.autoDispose<List<School>>((ref) {
  final filter = ref.watch(selectedDivisionsProvider);
  final schools = ref.watch(schoolsProvider);

  return schools.value
          ?.where((school) => filter[school.currentDivision] ?? false)
          .toList() ??
      [];
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
