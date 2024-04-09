import 'package:dio_image_provider/dio_image_provider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/app_fade_in_image.dart';
import '../../../../extensions/media_query_context_extension.dart';
import '../../../../extensions/theme_of_context_extension.dart';
import '../../../../utils/unmodifiable_list.dart';
import '../../instrument.dart';

class InstrumentHeaderImages extends StatelessWidget {
  const InstrumentHeaderImages({
    required this.instrument,
    required this.imageHeight,
    super.key,
  });

  final Instrument instrument;

  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final imageQuantity = context.querySize.isSmallScreen ? 2 : 3;
    final largeImageHeight =
        imageHeight * imageQuantity + (imageQuantity - 1) * 16;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    for (var i = 0; i < imageQuantity; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => showImage(
                            context,
                            UnmodifiableList([
                              ...instrument.gallery.take(3),
                              instrument.imageUrl,
                            ]),
                            initialIndex: i,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: SizedBox(
                              height: imageHeight,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: AppFadeInImage(
                                  instrument.gallery[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => showImage(
                      context,
                      UnmodifiableList(
                        [...instrument.gallery.take(3), instrument.imageUrl],
                      ),
                      initialIndex: 3,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: Hero(
                      flightShuttleBuilder: _flightShuttleBuilder,
                      tag: instrument.imageUrl,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: SizedBox(
                          height: largeImageHeight,
                          child: AppFadeInImage(
                            instrument.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text.rich(
                TextSpan(
                  text: instrument.translatedName,
                  children: [
                    if (instrument.name != instrument.translatedName)
                      TextSpan(
                        text: ' ${instrument.name}',
                        style: TextStyle(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                  ],
                ),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) =>
      switch (flightDirection) {
        HeroFlightDirection.push => Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: animation.drive(
                Tween<double>(begin: 0.1, end: 1).chain(
                  CurveTween(
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                ),
              ),
              child: toHeroContext.widget,
            ),
          ),
        HeroFlightDirection.pop => Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: animation.drive(
                Tween<double>(begin: 1, end: 0.1).chain(
                  CurveTween(
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                ),
              ),
              child: toHeroContext.widget,
            ),
          )
      };

  void showImage(
    BuildContext context,
    UnmodifiableList<String> images, {
    int? initialIndex,
  }) {
    final multiImageProvider = MultiImageProvider(
      [
        for (final image in images) DioImage(Uri.parse(image)),
      ],
      initialIndex: initialIndex ?? 0,
    );

    showImageViewerPager(
      context,
      multiImageProvider,
    );
  }
}
