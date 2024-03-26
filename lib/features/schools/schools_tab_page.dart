import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_button.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
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

class SchoolsTabPage extends ConsumerStatefulWidget {
  const SchoolsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const SchoolsTabPage(),
    ),
  );

  @override
  ConsumerState<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: <Widget>[
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: largeScreen,
            child: AppCupertinoSliverNavBar(
              largeTitle: 'Schools'.hardcoded,
              leading: PullDownButton(
                menuOffset: context.querySize.currentRailWidth,
                itemBuilder: (context) => [
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
          ),
          SliverSafeArea(
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
                                    title: const Text('Sort by'),
                                    titleStyle: context.textTheme.labelLarge,
                                  ),
                                  for (final sort in SchoolSort.values)
                                    PullDownMenuItem.selectable(
                                      onTap: () {
                                        ref
                                            .read(
                                              selectedSchoolSortProvider
                                                  .notifier,
                                            )
                                            .setSort(sort);
                                      },
                                      selected: sort ==
                                          ref.watch(selectedSchoolSortProvider),
                                      title: sort.fullName,
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
          ),
          if (ref.watch(schoolDivisionsProvider).length > 1)
            const SliverSafeArea(
              top: false,
              bottom: false,
              sliver: SliverCrossAxisConstrained(
                maxCrossAxisExtent: largeScreen,
                child: SchoolDivisionChips(),
              ),
            ),
          SliverSafeArea(
            top: false,
            sliver: SliverAnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: ref.watch(schoolsProvider).when(
                    data: (schools) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final schools = ref.watch(filteredSchoolsProvider);
                          return SliverCrossAxisConstrained(
                            maxCrossAxisExtent: largeScreen,
                            child: SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              sliver: SliverAlignedGrid.extent(
                                maxCrossAxisExtent: SchoolCard.cardMaxWidth,
                                itemCount: schools.length,
                                itemBuilder: (context, index) {
                                  final school = schools[index];
                                  return ProviderScope(
                                    overrides: [
                                      currentSchoolProvider.overrideWithValue(
                                        schools.firstWhere(
                                          (s) => s.id == school.id,
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
                      );
                    },
                    loading: () => const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                    error: (error, stackTrace) => SliverFillRemaining(
                      child: Center(
                        child: Text('Error: $error'),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
