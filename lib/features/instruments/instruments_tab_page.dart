import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../extensions/app_localization_extension.dart';
import '../../extensions/media_query_context_extension.dart';
import '../../router/go_route_scroll_tab.dart';
import '../../utils/unmodifiable_list.dart';
import 'details/instrument_details_page.dart';
import 'instruments_tab_providers.dart';
import 'widgets/instrument_list_tile.dart';

class InstrumentsTabPage extends ConsumerWidget {
  const InstrumentsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/instruments',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const InstrumentsTabPage(),
    ),
    routes: UnmodifiableList([
      InstrumentDetailsPage.route,
    ]),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxCrossAxisExtent = largeScreen;
    final instruments = ref.watch(instrumentsTabProvider);
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverCrossAxisConstrained(
              maxCrossAxisExtent: maxCrossAxisExtent,
              child: SliverMainAxisGroup(
                slivers: [
                  AppCupertinoSliverNavigationBar(
                    largeTitle: context.loc.instrumentsTitle,
                    transitionBetweenRoutes: false,
                  ),
                  const SliverPadding(padding: EdgeInsets.only(top: 8)),
                  SliverAnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: switch (instruments) {
                      AsyncLoading() => const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      AsyncError(:final error) => SliverFillRemaining(
                          child: Center(
                            child: Text(
                              error.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      AsyncData(:final value) => SliverSafeArea(
                          top: false,
                          sliver: SliverAlignedGrid.extent(
                            maxCrossAxisExtent: InstrumentListTile.cardMaxWidth,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              final instrument = value[index];
                              return InstrumentListTile(
                                title: instrument.name,
                                subtitle: instrument.description,
                                index: index,
                                onTap: () {
                                  context.go(
                                    '${InstrumentsTabPage.route.path}/${InstrumentDetailsPage.route.path}',
                                    extra: {'id': instrument.id},
                                  );
                                },
                                imageUrl: instrument.imageUrl,
                              );
                            },
                          ),
                        ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
