import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../schools_tab_providers.dart';

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
