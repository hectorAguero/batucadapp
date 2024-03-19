import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppImageNetwork extends StatelessWidget {
  const AppImageNetwork(
    this.url, {
    this.height,
    this.width,
    this.fit,
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
