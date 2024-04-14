import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../common_widgets/web_padding.dart';
import '../../extensions/app_localization_extension.dart';
import '../../extensions/media_query_context_extension.dart';
import '../home/home_page_controller.dart';
import 'instruments_tab_providers.dart';
import 'widgets/instrument_list_tile.dart';

class InstrumentsTabPage extends ConsumerWidget {
  const InstrumentsTabPage({super.key});

  static const tab = HomeTab.instruments;
  static const path = '/instruments';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxCrossAxisExtent = largeScreen;
    final instruments = ref.watch(instrumentsTabProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: maxCrossAxisExtent,
            child: SliverMainAxisGroup(
              slivers: [
                AppCupertinoSliverNavigationBar(
                  largeTitle: context.loc.instrumentsTitle,
                ),
                const SliverPadding(padding: EdgeInsets.only(top: 8)),
                SliverAnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: switch (instruments) {
                    AsyncLoading() => const SliverFillRemaining(
                        key: ValueKey('loading'),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    AsyncError(:final error) => SliverFillRemaining(
                        key: const ValueKey('error'),
                        child: Center(
                          child: Text(
                            error.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    AsyncData(:final value) => WebPaddingSliver.only(
                        right: true,
                        sliver: SliverSafeArea(
                          top: false,
                          sliver: SliverAlignedGrid.extent(
                            maxCrossAxisExtent: InstrumentListTile.cardMaxWidth,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              final instrument = value[index];
                              return InstrumentListTile(
                                title: instrument.translatedName,
                                originalTitle: instrument.name,
                                subtitle: instrument.translatedDescription,
                                index: index,
                                onTap: () {
                                  context.go(
                                    '$path/details/${instrument.id}',
                                  );
                                },
                                imageUrl: instrument.imageUrl,
                              );
                            },
                          ),
                        ),
                      ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
