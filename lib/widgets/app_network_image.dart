import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage.network(
    this.url, {
    this.fit,
    this.height,
    this.width,
    super.key,
  });

  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    /// This is a simple wrapper around [Image.network] to make it easier to
    /// switch to extended_image later.
    return Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }
}

typedef AppNetworkImage = NetworkImage;
