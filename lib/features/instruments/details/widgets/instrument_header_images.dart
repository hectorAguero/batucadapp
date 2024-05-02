import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/app_fade_in_image.dart';
import '../../../../core/extensions/theme_of_context_extension.dart';
import '../../../../utils/screen_size.dart';
import '../../instrument.dart';
import '../gallery_page/instruments_gallery_page.dart';

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
    final imageQuantity = context.screenSize.isSmall ? 2 : 3;
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
                            instrumentId: instrument.id,
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
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => showImage(
                        context,
                        instrumentId: instrument.id,
                        initialIndex: 3,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
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

  void showImage(
    BuildContext context, {
    required int instrumentId,
    required int initialIndex,
  }) {
    context.go(
      '/instruments/details/$instrumentId/${InstrumentsGalleryPage.path}',
      extra: {
        'index': initialIndex.toString(),
        'id': instrumentId.toString(),
      },
    );
  }
}
