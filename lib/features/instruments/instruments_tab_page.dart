import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../common_widgets/app_async_widget.dart';
import '../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../common_widgets/app_web_padding.dart';
import '../../core/extensions/app_localization_extension.dart';
import '../../utils/screen_size.dart';
import '../home/home_page_controller.dart';
import 'instruments_tab_providers.dart';
import 'widgets/instrument_list_tile.dart';

class InstrumentsTabPage extends ConsumerWidget {
  const InstrumentsTabPage({super.key});

  static const tab = HomeTab.instruments;
  static const path = '/instruments';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: ScreenSize.lg.value,
            child: SliverMainAxisGroup(
              slivers: [
                AppCupertinoSliverNavigationBar(
                  largeTitle: context.loc.instrumentsTitle,
                ),
                const SliverPadding(padding: EdgeInsets.only(top: 8)),
                SliverAnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: AppAsyncSliverWidget(
                    asyncValue: ref.watch(instrumentsTabProvider),
                    onErrorRetry: () => ref.invalidate(instrumentsTabProvider),
                    child: (value) => WebPaddingSliver.only(
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
