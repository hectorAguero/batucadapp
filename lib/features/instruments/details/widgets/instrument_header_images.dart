import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/widgets/app_network_image.dart';

class InstrumentHeaderImages extends StatelessWidget {
  const InstrumentHeaderImages({
    required this.instrument,
    this.imageHeight = 80.0,
    super.key,
  });

  final Instrument instrument;

  final double imageHeight;

  @override
  Widget build(BuildContext context) {
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
                    for (var i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => showImage(context),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: AppImage.network(
                              'https://picsum.photos/id/100/4912/3264',
                              height: imageHeight,
                              fit: BoxFit.cover,
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
                    onTap: () => showImage(context),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              instrument.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              instrument.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
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
