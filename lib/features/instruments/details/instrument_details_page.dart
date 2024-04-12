import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../../common_widgets/go_back_button.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/media_query_context_extension.dart';
import 'instrument_details_providers.dart';
import 'widgets/instrument_details_summary.dart';
import 'widgets/instrument_header_images.dart';

typedef InstrumentId = int;

enum InstrumentDetailsTab { summary, learning }

class InstrumentDetailsPage extends ConsumerStatefulWidget {
  const InstrumentDetailsPage({required this.id, super.key});

  final InstrumentId id;

  static GoRoute route = GoRoute(
    path: 'details/:id',
    builder: (context, state) {
      final pathParams = state.extra! as Map<String, dynamic>;
      final id = pathParams['id'] as int;
      return InstrumentDetailsPage(id: id);
    },
  );

  @override
  ConsumerState<InstrumentDetailsPage> createState() =>
      _InstrumentDetailsPageState();
}

class _InstrumentDetailsPageState extends ConsumerState<InstrumentDetailsPage> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(instrumentDetailsProvider(widget.id));
    const imageHeight = 80.0;
    const screenConstraint = largeScreen;
    return DefaultTabController(
      length: InstrumentDetailsTab.values.length,
      child: Scaffold(
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverCrossAxisConstrained(
                  maxCrossAxisExtent: screenConstraint,
                  child: AppCupertinoSliverNavigationBar(
                    leading: const GoBackButton(),
                    largeTitle: context.loc.instrumentDetails,
                    stretch: true,
                    transitionBetweenRoutes: false,
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
                  SliverCrossAxisConstrained(
                    maxCrossAxisExtent: screenConstraint,
                    child: SliverToBoxAdapter(
                      child: InstrumentHeaderImages(
                        instrument: value,
                        imageHeight: imageHeight,
                      ),
                    ),
                  ),
                  SliverCrossAxisConstrained(
                    maxCrossAxisExtent: smallScreen,
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
                  SliverCrossAxisConstrained(
                    maxCrossAxisExtent: screenConstraint,
                    child: SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      sliver: SliverToBoxAdapter(
                        // TODO(hectorAguero): hardcoded to avoid overscroll
                        child: SizedBox(
                          height: value.translatedDescription
                                      .calculateLines(
                                        context,
                                        width: screenConstraint,
                                      )
                                      .toDouble() *
                                  20 +
                              100,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

extension TextLinesExtension on String {
  int calculateLines(BuildContext context, {double? width, TextStyle? style}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: style ?? DefaultTextStyle.of(context).style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width ?? MediaQuery.of(context).size.width);
    return textPainter.computeLineMetrics().length;
  }
}
