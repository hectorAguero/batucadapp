import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/schools/details/schools_details_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_flag.dart';
import 'package:samba_public_app/widgets/app_page_indicator.dart';

class SchoolDetailsPage extends ConsumerStatefulWidget {
  const SchoolDetailsPage({
    required this.id,
    this.isModalSheet = false,
    super.key,
  });

  final int id;
  final bool isModalSheet;

  static GoRoute route = GoRoute(
    path: 'details/:id',
    builder: (context, state) {
      final pathParams = state.extra! as Map<String, dynamic>;
      final id = pathParams['id'] as int;
      return SchoolDetailsPage(id: id);
    },
  );

  @override
  ConsumerState<SchoolDetailsPage> createState() => _SchoolDetailsPageState();
}

class _SchoolDetailsPageState extends ConsumerState<SchoolDetailsPage> {
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(selectedSchoolProvider(widget.id));
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: ((constraints.maxWidth - 12) / 3) * 2,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Stack(
                children: [
                  PageView.builder(
                    clipBehavior: Clip.antiAlias,
                    itemCount: 3,
                    onPageChanged: (value) => currentPage.value = value,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: SchoolFlag(
                            heartSize: 32,
                            school: school,
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: currentPage,
                    builder: (context, index, child) {
                      return AppPageIndicator(pageCount: 3, currentPage: index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
        Text(school.name),
        Text(school.godmotherSchool),
      ],
    );
  }
}
