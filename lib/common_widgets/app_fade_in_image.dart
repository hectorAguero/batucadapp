// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../extensions/app_localization_extension.dart';
import '../extensions/theme_of_context_extension.dart';
import '../utils/main_logger.dart';

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
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: CachedNetworkImageProvider(image),
      imageErrorBuilder: (context, error, stackTrace) {
        logViews.info('Error loading image:', error, stackTrace);
        return AppErrorImageBuilder(
          height: height,
          textColor: context.colorScheme.onErrorContainer,
          backgroundColor: context.colorScheme.errorContainer,
          error: error.toString(),
          errorType: context.loc.errorLoadingImage,
          width: height,
        );
      },
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
    );
  }
}

class AppErrorImageBuilder extends StatelessWidget {
  const AppErrorImageBuilder({
    required this.width,
    required this.height,
    required this.error,
    required this.errorType,
    required this.backgroundColor,
    required this.textColor,
    super.key,
  });

  final double? width;
  final double? height;
  final String error;
  final String errorType;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: textColor,
              size: 50,
            ),
            // Error icon
            Text(
              errorType,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4), // Space between text and error message
            Text(
              error,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
