import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SchoolDivisionChips extends ConsumerWidget {
  const SchoolDivisionChips({
    this.margin = const EdgeInsets.symmetric(horizontal: 8),
    super.key,
  });

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDivisions = ref.watch(schoolDivisionsProvider);
    return SliverSafeArea(
      top: false,
      bottom: false,
      sliver: SliverCrossAxisConstrained(
        maxCrossAxisExtent: largeScreen,
        child: SliverToBoxAdapter(
          child: SizedBox(
            height: 64,
            child: ListView(
              padding: margin,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    showCheckmark: false,
                    selected:
                        selectedDivisions.values.every((element) => element),
                    label: Text('All'.hardcoded),
                    onSelected: (value) {
                      final notifier =
                          ref.read(schoolDivisionsProvider.notifier);
                      if (value) {
                        notifier.selectAll();
                      } else {
                        notifier.removeAll();
                      }
                    },
                  ),
                ),
                for (final (division, isActive)
                    in selectedDivisions.entries.map((e) => (e.key, e.value)))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onLongPress: () {
                        ref.read(schoolDivisionsProvider.notifier)
                          ..removeAll()
                          ..selectDivision(division);
                      },
                      child: FilterChip(
                        selected: isActive,
                        label: Text(division.fullName),
                        onSelected: (value) {
                          final notifier =
                              ref.read(schoolDivisionsProvider.notifier);
                          if (value) {
                            notifier.selectDivision(division);
                          } else {
                            notifier.removeDivision(division);
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
