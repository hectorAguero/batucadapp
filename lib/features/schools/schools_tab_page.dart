import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_button.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_rail.dart';
import 'package:samba_public_app/features/schools/school_sort.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_card.dart';
import 'package:samba_public_app/features/schools/widgets/school_division_chips.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SchoolsTabPage extends StatefulWidget {
  const SchoolsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const SchoolsTabPage(),
    ),
  );

  @override
  State<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends State<SchoolsTabPage> {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: PrimaryScrollController.of(context),
          slivers: <Widget>[
            const SchoolsTabNavBar(),
            const SchoolsTabSearchHeader(),
            Consumer(
              child: const SliverToBoxAdapter(child: SizedBox.shrink()),
              builder: (context, ref, child) {
                if (ref.watch(schoolDivisionsProvider).length > 1) {
                  return const SchoolDivisionChips();
                }
                return child!;
              },
            ),
            const SchoolsTabList(),
          ],
        ),
      ),
    );
  }
}

class SchoolsTabNavBar extends StatelessWidget {
  const SchoolsTabNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverCrossAxisConstrained(
      maxCrossAxisExtent: largeScreen,
      child: AppCupertinoSliverNavBar(
        largeTitle: context.loc.schoolsTitle,
        leading: PullDownButton(
          menuOffset: context.querySize.currentRailWidth,
          itemBuilder: (context) => [
            // TODO(hectorAguero): Get from the current schools API UPDATE
            PullDownMenuItem.selectable(
              title: '🇧🇷 Rio de Janeiro'.hardcoded,
              selected: true,
              onTap: () {},
            ),
          ],
          buttonBuilder: (context, showMenu) => AppCupertinoButton(
            onPressed: showMenu,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.ellipsis_circle),
          ),
        ),
      ),
    );
  }
}

class SchoolsTabSearchHeader extends ConsumerWidget {
  const SchoolsTabSearchHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverSafeArea(
      top: false,
      bottom: false,
      sliver: SliverCrossAxisConstrained(
        maxCrossAxisExtent: largeScreen,
        child: SliverPadding(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
          sliver: SliverCrossAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoSearchTextField(
                        onChanged: (value) => ref
                            .read(searchSchoolProvider.notifier)
                            .setSearch(value),
                      ),
                    ),
                    AppCupertinoButton(
                      onPressed: () {
                        showPullDownMenu(
                          context: context,
                          position: Rect.fromLTWH(
                            context.querySize.width > largeScreen
                                ? largeScreen +
                                    AdaptiveNavigationRail.largeRailWidth
                                : context.querySize.width,
                            100,
                            -48,
                            48,
                          ),
                          items: [
                            PullDownMenuTitle(
                              title: Text(context.loc.schoolSortBy),
                              titleStyle: context.textTheme.labelLarge,
                            ),
                            for (final sort in SchoolSort.values)
                              PullDownMenuItem.selectable(
                                onTap: () {
                                  ref
                                      .read(selectedSchoolSortProvider.notifier)
                                      .setSort(sort);
                                },
                                selected: sort ==
                                    ref.watch(selectedSchoolSortProvider),
                                title: sort.fullName(context),
                              ),
                          ],
                        );
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchoolsTabList extends ConsumerWidget {
  const SchoolsTabList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(schoolsProvider);
    return SliverSafeArea(
      top: false,
      sliver: SliverAnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: switch (future) {
          AsyncError(:final error) => SliverFillRemaining(
              child: Center(
                child: Text(
                  error.toString(),
                  style: context.textTheme.titleLarge,
                ),
              ),
            ),
          AsyncLoading() => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          AsyncData() => Consumer(
              builder: (context, ref, child) {
                final filteredSchools = ref.watch(filteredSchoolsProvider);
                return SliverCrossAxisConstrained(
                  maxCrossAxisExtent: largeScreen,
                  child: SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    sliver: SliverAlignedGrid.extent(
                      maxCrossAxisExtent: SchoolCard.cardMaxWidth,
                      itemCount: filteredSchools.length,
                      itemBuilder: (context, index) {
                        final school = filteredSchools[index];
                        return ProviderScope(
                          overrides: [
                            currentSchoolProvider.overrideWithValue(
                              filteredSchools.firstWhere(
                                (item) => item.id == school.id,
                              ),
                            ),
                          ],
                          child: const SchoolCard(),
                        );
                      },
                    ),
                  ),
                );
              },
            )
        },
      ),
    );
  }
}
