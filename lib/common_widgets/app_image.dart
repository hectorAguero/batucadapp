import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppImageNetwork extends StatelessWidget {
  const AppImageNetwork(
    this.imageUrl, {
    super.key,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      image: ExtendedNetworkImageProvider(
        imageUrl,
        cache: true,
      ),
    );
  }
}
