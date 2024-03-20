import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/extensions/is_ios_or_macos_platform_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
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
                  border: const Border(),
                  backgroundColor: Colors.transparent,
                  trailing: isSmallScreen
                      ? CupertinoButton(
                          onPressed: () {},
                          child: Icon(
                            kIsCupertino
                                ? CupertinoIcons.settings
                                : Icons.settings,
                            color: context.colorScheme.onSurface,
                          ),
                        )
                      : null,
                ),
                const SliverPadding(padding: EdgeInsets.only(top: 8)),
                SliverAnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: ref.watch(instrumentsTabProvider).when(
                        data: (data) => SliverAlignedGrid.count(
                          crossAxisCount: size.getAxisCount(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final mockInstrument = data[index];
                            return InstrumentListTile(
                              title: mockInstrument.name,
                              subtitle: mockInstrument.description,
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
        ),
      ],
    );
  }
}
