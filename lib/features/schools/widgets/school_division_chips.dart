import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';

class SchoolDivisionChips extends ConsumerWidget {
  const SchoolDivisionChips({
    this.margin = const EdgeInsets.symmetric(horizontal: 8),
    super.key,
  });

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDivisions = ref.watch(selectedDivisionsProvider);
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 64,
        child: ListView(
          padding: margin,
          scrollDirection: Axis.horizontal,
          children: [
            for (final (division, isActive)
                in selectedDivisions.entries.map((e) => (e.key, e.value)))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FilterChip(
                  selected: isActive,
                  label: Text(division.fullName),
                  onSelected: (value) {
                    final notif = ref.read(selectedDivisionsProvider.notifier);
                    if (value) {
                      notif.selectDivision(division);
                    } else {
                      notif.removeDivision(division);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
