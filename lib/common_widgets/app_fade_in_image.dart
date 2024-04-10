import 'package:dio_image_provider/dio_image_provider.dart';
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
      image: DioImage(Uri.parse(image)),
      imageErrorBuilder: (context, error, stackTrace) {
        viewLog.fine('Error loading image: $error');
        return AppErrorImageBuilder(
          height: height,
          error: error,
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
    super.key,
  });

  final double? width;
  final double? height;
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.error,
            context.colorScheme.errorContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: context.colorScheme.onError,
            size: 50,
          ),
          // Error icon
          Text(
            context.loc.errorLoadingImage,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.onErrorContainer,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4), // Space between text and error message
          Text(
            '$error',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.onError,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
