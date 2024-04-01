import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_page.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_providers.dart';
import 'package:samba_public_app/features/instruments/widgets/instrument_list_tile.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';
import 'package:sliver_tools/sliver_tools.dart';

class InstrumentsTabPage extends ConsumerWidget {
  const InstrumentsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/instruments',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const InstrumentsTabPage(),
    ),
    routes: [
      InstrumentDetailsPage.route,
    ],
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
                  AppCupertinoSliverNavBar(
                    largeTitle: context.loc.instrumentsTitle,
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
                              final mockInstrument = value[index];
                              return InstrumentListTile(
                                title: mockInstrument.name,
                                subtitle: mockInstrument.description,
                                index: index,
                                onTap: () {
                                  context.go(
                                    '${InstrumentsTabPage.route.path}/${InstrumentDetailsPage.route.path}',
                                    extra: {'id': mockInstrument.id},
                                  );
                                },
                                imageUrl: mockInstrument.imageUrl,
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
