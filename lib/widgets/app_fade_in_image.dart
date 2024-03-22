import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:transparent_image/transparent_image.dart';

class AppFadeInImage extends StatelessWidget {
  const AppFadeInImage(
    this.image, {
    this.height,
    this.width,
    this.fit,
    super.key,
  });

  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      colorBlendMode: BlendMode.dst,
      image: image,
      color: context.colorScheme.outlineVariant,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
