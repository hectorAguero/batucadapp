import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../../../extensions/js_bottom_padding_extension_web.dart';
import '../../../extensions/media_query_context_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../schools_tab_providers.dart';
import 'school_card.dart';

class SchoolsTabBody extends ConsumerWidget {
  const SchoolsTabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolsFuture = ref.watch(schoolsProvider);
    return SliverSafeArea(
      top: false,
      sliver: SliverAnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: switch (schoolsFuture) {
          AsyncData() => Consumer(
              builder: (context, ref, child) {
                final schools = ref.watch(filteredSchoolsProvider);
                return SliverCrossAxisConstrained(
                  maxCrossAxisExtent: largeScreen,
                  child: SliverPadding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16 + rightInset(),
                    ),
                    sliver: SliverAnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: schools.isEmpty
                          ? const SchoolsEmptyList()
                          : SliverDynamicHeightGridView(
                              itemCount: schools.length,
                              crossAxisCount:
                                  context.querySize.crossAxisCount(),
                              builder: (context, index) {
                                final school = schools[index];
                                return ProviderScope(
                                  overrides: [
                                    currentSchoolProvider.overrideWithValue(
                                      schools.firstWhere(
                                        (item) => item.id == school.id,
                                      ),
                                    ),
                                  ],
                                  child: const SchoolCard(),
                                );
                              },
                            ),
                    ),
                  ),
                );
              },
            ),
          AsyncError(:final error) => SliverFillRemaining(
              key: const ValueKey('error'),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      error.toString(),
                      style: context.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          AsyncLoading() => const SliverFillRemaining(
              key: ValueKey('loading'),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
        },
      ),
    );
  }
}

class SchoolsEmptyList extends ConsumerWidget {
  const SchoolsEmptyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ref.watch(schoolsProvider).value?.isEmpty ?? false) ...[
                const SizedBox(height: 8),
                Text(
                  context.loc.noSchoolsFound,
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                const SizedBox(height: 8),
                if (ref.watch(favoriteSchoolsProvider).isEmpty)
                  Text(
                    context.loc.noFavoriteSchools,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    context.loc.noFilteredSchools,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                CupertinoButton(
                  onPressed: () {
                    ref
                        .read(showOnlyFavoriteSchoolsProvider.notifier)
                        .turnOffShowFavorites();
                    ref.read(schoolDivisionsProvider.notifier).selectAll();
                  },
                  child: Text(context.loc.resetFilters),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
