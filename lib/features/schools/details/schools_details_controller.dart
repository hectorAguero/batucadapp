import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../school.dart';
import '../schools_tab_controller.dart';

part 'schools_details_controller.g.dart';

@riverpod
class SchoolsDetailsController extends _$SchoolsDetailsController {
  @override
  School build(int id) {
    final school = ref.watch(schoolsTabControllerProvider).requireValue;

    return school.firstWhere((school) => school.id == id);
  }
}
