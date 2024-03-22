import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/features/schools/details/schools_details_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_flag.dart';

class SchoolDetailsPage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final school = ref.watch(selectedSchoolProvider(id));
    return _ModalWrapper(
      isModalSheet: isModalSheet,
      child: Column(
        children: [
          SchoolFlag(
            heartSize: 32,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton.filledTonal(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            school: school,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
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
      ),
    );
  }
}

class _ModalWrapper extends StatelessWidget {
  const _ModalWrapper({required this.isModalSheet, required this.child});

  final bool isModalSheet;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isModalSheet) {
      return child;
    }
    return Scaffold(
      body: child,
    );
  }
}
