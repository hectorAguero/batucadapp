import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_animation_wrapper.dart';
import '../../../common_widgets/app_async_widget.dart';
import '../../../extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../../../extensions/js_bottom_padding_extension_web.dart';
import '../../../utils/immutable_list.dart';
import '../../../utils/screen_size.dart';
import '../school.dart';
import '../schools_tab_providers.dart';
import 'school_card.dart';
import 'schools_empty_list.dart';

class SchoolsTabBody extends ConsumerWidget {
  const SchoolsTabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverSafeArea(
      top: false,
      sliver: AppAsyncSliver(
        asyncValue: ref.watch(schoolsProvider),
        onErrorRetry: () => ref.invalidate(schoolsProvider),
        child: (value) => Consumer(
          builder: (context, ref, child) {
            final schools = ref.watch(filteredSchoolsProvider);
            return SliverCrossAxisConstrained(
              maxCrossAxisExtent: ScreenSize.lg.value,
              child: SliverPadding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16 + rightInset(),
                ),
                sliver: SliverAnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: schools.isEmpty
                      ? const SchoolsEmptyList()
                      : SliverSchoolsList(schools: schools),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SliverSchoolsList extends StatelessWidget {
  const SliverSchoolsList({
    required this.schools,
    super.key,
  });

  final ImmutableList<School> schools;

  @override
  Widget build(BuildContext context) {
    return SliverDynamicHeightGridView(
      itemCount: schools.length,
      crossAxisCount: gridCrossAxisCount(context),
      builder: (context, index) {
        final school = schools[index];
        return AppAnimationWrapper(
          child: ProviderScope(
            overrides: [
              currentSchoolProvider.overrideWithValue(school),
            ],
            child: const SchoolCard(),
          ),
        );
      },
    );
  }

  static int gridCrossAxisCount(BuildContext context) {
    return switch (context.screenSize) {
      ScreenSize.xs => 1,
      ScreenSize.md => 2,
      ScreenSize.lg => 3
    };
  }
}
