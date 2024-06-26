// ignore: depend_on_referenced_packages
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

import '../core/extensions/app_localization_extension.dart';
import '../core/extensions/theme_of_context_extension.dart';
import '../utils/app_loggers.dart';

typedef ImageErrorWidgetBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
);

class AppFadeInImage extends StatelessWidget {
  const AppFadeInImage(
    this.image, {
    this.height,
    this.width,
    this.fit,
    this.imageErrorBuilder,
    this.placeholder,
    this.fadeInDuration = const Duration(milliseconds: 300),
    super.key,
  });

  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ImageProvider<Object>? placeholder;
  final Duration fadeInDuration;
  final ImageErrorWidgetBuilder? imageErrorBuilder;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fadeInDuration: fadeInDuration,
      placeholder: placeholder ?? MemoryImage(kTransparentImage),
      placeholderColorBlendMode: BlendMode.color,
      image:
          ExtendedNetworkImageProvider(image, cache: true, printError: false),
      imageErrorBuilder: imageErrorBuilder ??
          (context, error, stackTrace) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorType,
            overflow: TextOverflow.ellipsis,
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
    );
  }
}
