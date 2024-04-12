import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../extensions/app_localization_extension.dart';
import '../../extensions/context_snackbar.dart';
import '../../extensions/media_query_context_extension.dart';
import '../../extensions/theme_of_context_extension.dart';
import '../../router/go_route_scroll_tab.dart';
import '../../utils/debouncer.dart';
import 'parades_tab_providers.dart';
import 'widgets/parade_item.dart';

class ParadesTabPage extends ConsumerStatefulWidget {
  const ParadesTabPage({required this.controller, super.key});
  final ScrollController controller;

  static final route = GoRouteScrollTab(
    path: '/parades',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: ParadesTabPage(
        controller: controller,
      ),
    ),
  );

  @override
  ConsumerState<ParadesTabPage> createState() => _ParadesTabPageState();
}

class _ParadesTabPageState extends ConsumerState<ParadesTabPage> {
  final _listController = ListController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  @override
  void initState() {
    widget.controller.addListener(_loadMoreListener);
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _listController.dispose();
    widget.controller.removeListener(_loadMoreListener);
    super.dispose();
  }

  void _loadMoreListener() {
    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent) {
      if (!ref.read(paradesTabReachedLimitProvider)) {
        final pixels = widget.controller.position.pixels;
        _debouncer.run(() {
          ref.read(paradesProvider.notifier).fetchNextPage().then((value) {
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
    final paradesFuture = ref.watch(paradesProvider);
    final reachedLimit = ref.watch(paradesTabReachedLimitProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      body: CustomScrollView(
        controller: widget.controller,
        slivers: [
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: mediumScreen,
            child: AppCupertinoSliverNavigationBar(
              largeTitle: context.loc.paradesTitle,
            ),
          ),
          SliverAnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: switch (paradesFuture) {
              AsyncError(:final error) => SliverFillRemaining(
                  key: const ValueKey('parades_error'),
                  child: Center(
                    child: Text(
                      error.toString(),
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                ),
              AsyncLoading() => const SliverFillRemaining(
                  key: ValueKey('parades_loading'),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              AsyncData(:final value) => SliverCrossAxisConstrained(
                  maxCrossAxisExtent: mediumScreen,
                  child: SuperSliverList.builder(
                    itemCount: value.length,
                    listController: _listController,
                    itemBuilder: (context, index) {
                      return ProviderScope(
                        overrides: [
                          currentParadeProvider.overrideWithValue(value[index]),
                        ],
                        child: Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(top: 24)
                              : EdgeInsets.zero,
                          child: const ParadeItem(),
                        ),
                      );
                    },
                  ),
                ),
            },
          ),
          SliverToBoxAdapter(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: reachedLimit
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          height: 16,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: widget.controller,
      alignment: 0.5,
      // You can provide duration and curve depending on the estimated
      // distance between currentPosition and the target item position.
      duration: (estimatedDistance) => const Duration(milliseconds: 250),
      curve: (estimatedDistance) => Curves.easeInOut,
    );
  }
}
