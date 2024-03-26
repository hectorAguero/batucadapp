import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    const maxCrossAxisExtent = largeScreen;
    return CustomScrollView(
      slivers: [
        SliverCrossAxisConstrained(
          maxCrossAxisExtent: maxCrossAxisExtent,
          child: SliverMainAxisGroup(
            slivers: [
              AppCupertinoSliverNavBar(largeTitle: 'Instruments'.hardcoded),
              const SliverPadding(padding: EdgeInsets.only(top: 8)),
              SliverAnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: ref.watch(instrumentsTabProvider).when(
                      data: (instruments) => SliverAlignedGrid.extent(
                        maxCrossAxisExtent: InstrumentListTile.cardMaxWidth,
                        itemCount: instruments.length,
                        itemBuilder: (context, index) {
                          final mockInstrument = instruments[index];
                          return InstrumentListTile(
                            title: mockInstrument.name,
                            subtitle: mockInstrument.description,
                            backgroundColor: index.isEven
                                ? colorScheme.primaryContainer
                                : colorScheme.secondaryContainer,
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
                      error: (error, stackTrace) => SliverFillRemaining(
                        child: Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                      loading: () => const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
