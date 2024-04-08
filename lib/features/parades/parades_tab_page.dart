import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_navigation_bar.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/intl_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/parades/parades_tab_providers.dart';
import 'package:samba_public_app/features/parades/widgets/parade_item.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class ParadesTabPage extends ConsumerStatefulWidget {
  const ParadesTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/parades',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const ParadesTabPage(),
    ),
  );

  @override
  ConsumerState<ParadesTabPage> createState() => _ParadesTabPageState();
}

class _ParadesTabPageState extends ConsumerState<ParadesTabPage> {
  final _listController = ListController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _listController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paradesFuture = ref.watch(paradesProvider);
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverCrossAxisConstrained(
              maxCrossAxisExtent: mediumScreen,
              child: AppCupertinoSliverNavigationBar(
                largeTitle: context.loc.paradesTitle,
              ),
            ),
            if (paradesFuture.value != null)
              SliverCrossAxisConstrained(
                maxCrossAxisExtent: mediumScreen,
                child: SliverPinnedHeader(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (final (index, item)
                                in (paradesFuture.value!).indexed)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ChoiceChip(
                                  selected: false,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  onSelected: (_) => animateToItem(index),
                                  label: Text(
                                    '${item.placing.ordinal(context)}'
                                    ' ${context.loc.schoolPerformancePlace}',
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            switch (paradesFuture) {
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
                    child: CircularProgressIndicator(),
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
          ],
        ),
      ),
    );
  }

  void animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: _scrollController,
      alignment: 0.5,
      // You can provide duration and curve depending on the estimated
      // distance between currentPosition and the target item position.
      duration: (estimatedDistance) => const Duration(milliseconds: 250),
      curve: (estimatedDistance) => Curves.easeInOut,
    );
  }
}
