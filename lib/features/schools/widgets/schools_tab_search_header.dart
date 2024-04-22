import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../common_widgets/app_web_padding.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../utils/screen_size.dart';
import '../../home/widgets/adaptive_navigation_rail.dart';
import '../school.dart';
import '../schools_tab_controller.dart';

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
  Widget build(BuildContext context) {
    // Watch to not dispose the provider
    ref.watch(searchedSchoolProvider);

    return WebPaddingSliver.only(
      right: true,
      sliver: SliverSafeArea(
        top: false,
        bottom: false,
        sliver: SliverCrossAxisConstrained(
          maxCrossAxisExtent: ScreenSize.lg.value,
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
                                        .read(
                                          selectedSchoolSortProvider.notifier,
                                        )
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Rect calculateRect(BuildContext context) {
    const top = 100.0;
    const height = 48.0;
    if (context.screenSize.isLarge) {
      final left = ScreenSize.lg.value + AdaptiveNavigationRail.largeRailWidth;
      const largeWidth = -48.0;

      return Rect.fromLTWH(left, top, largeWidth, height);
    }
    const width = 48.0;
    final left = MediaQuery.sizeOf(context).width - 48;

    return Rect.fromLTWH(left, top, width, height);
  }
}
