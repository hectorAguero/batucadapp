import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_page.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/widgets/instrument_list_tile.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';

class InstrumentsTab extends StatelessWidget {
  const InstrumentsTab({super.key});

  static final route = GoRouteScrollTab(
    path: '/instruments',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const InstrumentsTab(),
    ),
    routes: [
      InstrumentDetailsPage.route,
    ],
  );

  @override
  Widget build(BuildContext context) {
    final size = context.querySize;
    final isSmallScreen = size.isSmallScreen;
    return CustomScrollView(
      slivers: [
        SliverLayoutBuilder(
          builder: (context, constraints) => SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 0 : constraints.crossAxisExtent * 0.1,
            ),
            sliver: SliverMainAxisGroup(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text('Instruments'),
                  backgroundColor:
                      CupertinoColors.systemGroupedBackground.withOpacity(0.95),
                  border: const Border(),
                ),
                SliverAlignedGrid.count(
                  crossAxisCount: size.getAxisCount(),
                  itemBuilder: (context, index) => InstrumentListTile(
                    title: mockInstrument.name,
                    subtitle: mockInstrument.description,
                    onTap: () {
                      context.go(
                        '${InstrumentsTab.route.path}/${InstrumentDetailsPage.route.path}',
                        extra: {'id': mockInstrument.id},
                      );
                    },
                    imageUrl: mockInstrument.imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
