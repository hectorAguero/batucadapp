import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/common_widgets/go_back_button.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_providers.dart';
import 'package:samba_public_app/features/instruments/details/widgets/instrument_details_gallery.dart';
import 'package:samba_public_app/features/instruments/details/widgets/instrument_details_summary.dart';
import 'package:samba_public_app/features/instruments/details/widgets/instrument_details_type.dart';
import 'package:samba_public_app/features/instruments/details/widgets/instrument_header_images.dart';
import 'package:sliver_tools/sliver_tools.dart';

typedef InstrumentId = int;

enum InstrumentDetailsTab {
  summary,
  type,
  gallery,
}

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
    final data = ref.watch(instrumentDetailsProvider(widget.id));
    const imageHeight = 160.0;
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
                  child: CupertinoSliverNavigationBar(
                    leading: const GoBackButton(),
                    border: const Border(),
                    backgroundColor: Colors.transparent,
                    largeTitle: Text('Instrument Details'.hardcoded),
                    stretch: true,
                  ),
                ),
              ),
            ];
          },
          body: AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: data.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              data: (instrument) => Builder(
                builder: (context) => CustomScrollView(
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
                          instrument: instrument,
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
                            overlayColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            tabs: [
                              Tab(text: 'Summary'.hardcoded),
                              Tab(text: 'Type'.hardcoded),
                              Tab(text: 'Gallery'.hardcoded),
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
                          // TODO(hectorAguero): size needed to avoid overscroll
                          child: SizedBox(
                            height: 800,
                            child: TabBarView(
                              physics: const ClampingScrollPhysics(),
                              children: [
                                InstrumentDetailsSummary(
                                  details: instrument.description,
                                ),
                                const InstrumentDetailsType(),
                                const InstrumentDetailsGallery(),
                              ],
                            ),
                          ),
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
    );
  }
}
