import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/immutable_list.dart';
import '../instrument_details_controller.dart';

class InstrumentsGalleryPage extends ConsumerStatefulWidget {
  const InstrumentsGalleryPage({
    required this.initialIndex,
    required this.instrumentId,
    this.withScaffold = false,
    super.key,
  });

  final int initialIndex;
  final int instrumentId;
  final bool withScaffold;

  static const path = 'images';

  @override
  ConsumerState<InstrumentsGalleryPage> createState() =>
      _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends ConsumerState<InstrumentsGalleryPage> {
  late ImmutableList<String> images = ref.watch(
    instrumentDetailsControllerProvider(widget.instrumentId).select(
      (value) => value.gallery,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        children: [
          ExtendedImageGesturePageView.builder(
            controller: ExtendedPageController(
              initialPage: widget.initialIndex,
            ),
            onPageChanged: (int page) {
              _preloadImage(page - 1);
              _preloadImage(page + 1);
            },
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return ExtendedImage.network(
                images[index],
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (ExtendedImageState state) {
                  return GestureConfig(
                    inPageView: true,
                    animationMaxScale: 6.0,
                  );
                },
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CupertinoButton(
                  child: const Icon(CupertinoIcons.xmark, color: Colors.white),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImage(1);
  }

  final List<int> _cachedIndexes = <int>[];

  void _preloadImage(int index) {
    if (_cachedIndexes.contains(index)) {
      return;
    }
    if (0 <= index && index < images.length) {
      final String url = images[index];

      precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);

      _cachedIndexes.add(index);
    }
  }
}
