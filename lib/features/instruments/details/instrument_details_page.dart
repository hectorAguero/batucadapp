import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_back_button.dart';
import '../../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../../common_widgets/app_web_padding.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/text_lines_extension.dart';
import '../../../utils/screen_size.dart';
import '../instrument.dart';
import 'instrument_details_controller.dart';
import 'widgets/instrument_details_summary.dart';
import 'widgets/instrument_header_images.dart';

typedef InstrumentId = int;

class InstrumentDetailsPage extends ConsumerStatefulWidget {
  const InstrumentDetailsPage({required this.id, super.key});

  final InstrumentId id;
  static const path = 'details/:id';
  static const bottomPaddingContent = 200.0;

  @override
  ConsumerState<InstrumentDetailsPage> createState() =>
      _InstrumentDetailsPageState();
}

enum InstrumentDetailsTab { summary, learning }

class _InstrumentDetailsPageState extends ConsumerState<InstrumentDetailsPage> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(instrumentDetailsControllerProvider(widget.id));
    final screenConstraint = ScreenSize.lg.value;
    const imageHeight = 80.0;

    return DefaultTabController(
      length: InstrumentDetailsTab.values.length,
      child: Scaffold(
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, _) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverCrossAxisConstrained(
                  maxCrossAxisExtent: screenConstraint,
                  child: AppCupertinoSliverNavigationBar(
                    leading: const AppBackButton(),
                    largeTitle: context.loc.instrumentDetails,
                    stretch: true,
                  ),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                  ),
                  WebPaddingSliver.only(
                    right: true,
                    sliver: SliverCrossAxisConstrained(
                      maxCrossAxisExtent: screenConstraint,
                      child: SliverToBoxAdapter(
                        child: InstrumentHeaderImages(
                          instrument: value,
                          imageHeight: imageHeight,
                        ),
                      ),
                    ),
                  ),
                  WebPaddingSliver.only(
                    right: true,
                    sliver: SliverSafeArea(
                      top: false,
                      bottom: false,
                      sliver: SliverCrossAxisConstrained(
                        maxCrossAxisExtent: ScreenSize.md.value,
                        child: SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: TabBar(
                              overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              tabs: [
                                Tab(text: context.loc.instrumentDescription),
                                Tab(text: context.loc.instrumentLearning),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  WebPaddingSliver.only(
                    right: true,
                    sliver: SliverCrossAxisConstrained(
                      maxCrossAxisExtent: screenConstraint,
                      child: SliverPadding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.paddingOf(context).left + 8,
                          right: MediaQuery.paddingOf(context).right + 8,
                          top: 8,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height: _height(value, context, screenConstraint),
                            child: TabBarView(
                              physics: const ClampingScrollPhysics(),
                              children: [
                                InstrumentDetailsSummary(
                                  details: value.translatedDescription,
                                ),
                                InstrumentDetailsSummary(
                                  details: value.translatedDescription,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  double _height(
    Instrument value,
    BuildContext context,
    double screenConstraint,
  ) {
    return value.translatedDescription.calculateHeightByLines(
      context,
      width: screenConstraint,
      paddingHeight: InstrumentDetailsPage.bottomPaddingContent,
    );
  }
}
