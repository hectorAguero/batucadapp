import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/string_extension.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_providers.dart';
import 'package:samba_public_app/features/instruments/details/widgets/details_gallery.dart';
import 'package:samba_public_app/features/instruments/details/widgets/details_summary.dart';
import 'package:samba_public_app/features/instruments/details/widgets/details_type.dart';
import 'package:samba_public_app/widgets/app_network_image.dart';
import 'package:samba_public_app/widgets/go_back_button.dart';
import 'package:sliver_tools/sliver_tools.dart';

typedef InstrumentId = int;

enum InstrumentDetailsTab {
  summary,
  type,
  gallery,
}

class InstrumentDetailsPage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(instrumentDetailsProvider(id));
    const imageHeight = 160.0;
    return DefaultTabController(
      length: InstrumentDetailsTab.values.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const SliverCrossAxisConstrained(
                  maxCrossAxisExtent: mediumScreen,
                  child: CupertinoSliverNavigationBar(
                    leading: GoBackButton(),
                    border: Border(),
                    backgroundColor: Colors.transparent,
                    largeTitle: Text('Instrument Details'),
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
                builder: (context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      for (var i = 0; i < 3; i++)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: InkWell(
                                            onTap: () => showImage(context),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: const ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: AppImage.network(
                                                'https://picsum.photos/id/100/4912/3264',
                                                height: imageHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: InkWell(
                                        onTap: () => showImage(context),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: const ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: AppImage.network(
                                            'https://picsum.photos/id/100/4912/3264',
                                            height: imageHeight * 3 + 32,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    instrument.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    instrument.description,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              TabBar(
                                tabs: [
                                  for (final tab in InstrumentDetailsTab.values)
                                    Tab(text: tab.name.capitalize),
                                ],
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    for (final tab
                                        in InstrumentDetailsTab.values)
                                      SafeArea(
                                        top: false,
                                        bottom: false,
                                        child: Builder(
                                          builder: (BuildContext context) {
                                            return CustomScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              primary: false,
                                              slivers: <Widget>[
                                                SliverCrossAxisConstrained(
                                                  maxCrossAxisExtent:
                                                      mediumScreen,
                                                  child: SliverToBoxAdapter(
                                                    child: switch (tab) {
                                                      InstrumentDetailsTab
                                                            .summary =>
                                                        DetailsSummary(
                                                          detailsDescription:
                                                              instrument
                                                                  .details!,
                                                        ),
                                                      InstrumentDetailsTab
                                                            .type =>
                                                        const DetailsType(),
                                                      InstrumentDetailsTab
                                                            .gallery =>
                                                        const DetailsGallery(),
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImage(BuildContext context) {
    final multiImageProvider = MultiImageProvider([
      const NetworkImage(
        'https://picsum.photos/id/1001/4912/3264',
      ),
      const NetworkImage(
        'https://picsum.photos/id/1003/1181/1772',
      ),
      const NetworkImage(
        'https://picsum.photos/id/1004/4912/3264',
      ),
      const NetworkImage(
        'https://picsum.photos/id/1005/4912/3264',
      ),
    ]);

    showImageViewerPager(
      context,
      multiImageProvider,
    );
  }
}
