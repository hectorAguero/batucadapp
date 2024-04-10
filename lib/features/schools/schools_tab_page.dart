import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/app_localization_extension.dart';
import '../../extensions/context_snackbar.dart';
import '../../router/go_route_scroll_tab.dart';
import '../../utils/debouncer.dart';
import 'schools_tab_providers.dart';
import 'widgets/school_division_chips.dart';
import 'widgets/schools_tab_list.dart';
import 'widgets/schools_tab_navbar.dart';
import 'widgets/schools_tab_search_header.dart';

class SchoolsTabPage extends ConsumerStatefulWidget {
  const SchoolsTabPage({required this.controller, super.key});
  final ScrollController controller;

  static final route = GoRouteScrollTab(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: SchoolsTabPage(controller: controller),
    ),
  );

  @override
  ConsumerState<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTabPage> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  @override
  void initState() {
    widget.controller.addListener(_loadMoreListener);
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    widget.controller.removeListener(_loadMoreListener);
    super.dispose();
  }

  void _loadMoreListener() {
    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent) {
      if (ref.read(filteredSchoolsProvider).length !=
          ref.read(schoolsProvider).value?.length) {
        return;
      }
      if (!ref.read(schoolsTabReachedLimitProvider)) {
        final pixels = widget.controller.position.pixels;
        _debouncer.run(() {
          ref.read(schoolsProvider.notifier).fetchNextPage().then((value) {
            if (value == null) {
            } else if (value && widget.controller.hasClients) {
              widget.controller.jumpTo(pixels);
              Future.delayed(
                const Duration(milliseconds: 50),
                () => widget.controller.animateTo(
                  pixels + 64 + 40,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                ),
              );
            } else {
              context.showSnackBarText(context.loc.noMoreSchools);
            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return SelectionArea(
          child: Scaffold(
            body: GestureDetector(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
              },
              child: CustomScrollView(
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
                  Consumer(
                    builder: (context, ref, child) {
                      final reachedLimit =
                          ref.watch(schoolsTabReachedLimitProvider);
                      final isEmpty =
                          ref.watch(filteredSchoolsProvider).isEmpty;
                      final isFiltered =
                          ref.watch(filteredSchoolsProvider).length !=
                              ref.watch(schoolsProvider).value?.length;
                      return SliverToBoxAdapter(
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: reachedLimit || isEmpty || isFiltered
                              ? const SizedBox.shrink()
                              : const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      height: 16,
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
