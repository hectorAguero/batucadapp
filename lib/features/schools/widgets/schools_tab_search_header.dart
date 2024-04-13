import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/media_query_context_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../home/widgets/adaptive_navigation_rail.dart';
import '../school.dart';
import '../schools_tab_providers.dart';

class SchoolsTabSearchHeader extends ConsumerStatefulWidget {
  const SchoolsTabSearchHeader({super.key});

  @override
  ConsumerState<SchoolsTabSearchHeader> createState() =>
      _SchoolsTabSearchHeaderState();
}

class _SchoolsTabSearchHeaderState
    extends ConsumerState<SchoolsTabSearchHeader> {
  late final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch to not dispose the provider
    ref.watch(searchedSchoolProvider);
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
                        placeholder: context.loc.search,
                        controller: controller,
                        onSubmitted: (value) => ref
                            .read(searchedSchoolProvider.notifier)
                            .setSearch(value),
                        onSuffixTap: () {
                          controller.clear();
                          ref
                              .read(searchedSchoolProvider.notifier)
                              .setSearch('');
                        },
                      ),
                    ),
                    AppCupertinoButton(
                      onPressed: () {
                        showPullDownMenu(
                          context: context,
                          position: calculateRect(context),
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

  Rect calculateRect(BuildContext context) => Rect.fromLTWH(
        context.querySize.width > largeScreen
            ? largeScreen + AdaptiveNavigationRail.largeRailWidth
            : context.querySize.width,
        100,
        -48,
        48,
      );
}
