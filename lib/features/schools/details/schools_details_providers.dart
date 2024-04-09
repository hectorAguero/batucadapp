import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../school.dart';
import '../schools_tab_providers.dart';

part 'schools_details_providers.g.dart';

@riverpod
class SelectedSchool extends _$SelectedSchool {
  @override
  School build(int id) {
    final school = ref.watch(schoolsProvider).value!.firstWhere(
          (school) => school.id == id,
        );
    return school;
  }
}
