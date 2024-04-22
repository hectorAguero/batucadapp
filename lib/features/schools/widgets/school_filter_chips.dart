import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../utils/screen_size.dart';
import '../school_extensions.dart';
import '../schools_tab_controller.dart';

class SchoolFilterChips extends ConsumerWidget {
  const SchoolFilterChips({
    this.margin = const EdgeInsets.symmetric(horizontal: 8),
    super.key,
  });

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDivisions = ref.watch(schoolDivisionsProvider);
    final padding = MediaQuery.paddingOf(context);

    return SliverCrossAxisConstrained(
      maxCrossAxisExtent: ScreenSize.lg.value,
      child: SliverToBoxAdapter(
        child: SizedBox(
          height: 64,
          child: ListView(
            padding: EdgeInsets.only(
              left: padding.left + margin.left,
              right: padding.right + margin.right,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4, left: 8),
                child: ChoiceChip(
                  showCheckmark: false,
                  avatar: !ref.watch(showOnlyFavoriteSchoolsProvider)
                      ? const Icon(CupertinoIcons.heart)
                      : const Icon(CupertinoIcons.heart_fill),
                  selected: ref.watch(showOnlyFavoriteSchoolsProvider),
                  label: Text(context.loc.schoolFavorites),
                  selectedColor: context.colorScheme.primaryContainer,
                  onSelected: (value) {
                    ref
                        .read(showOnlyFavoriteSchoolsProvider.notifier)
                        .toggleShowFavorites();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  showCheckmark: false,
                  selected:
                      selectedDivisions.values.every((element) => element),
                  label: Text(context.loc.all),
                  onSelected: (value) {
                    final notifier = ref.read(schoolDivisionsProvider.notifier);
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
                      label: Text(division.fullName(context)),
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
    );
  }
}
