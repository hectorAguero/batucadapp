import 'package:flutter/material.dart';

enum ScreenSize {
  xs,
  md,
  lg;

  bool get isSmall => this == ScreenSize.xs;
  bool get isMedium => this == ScreenSize.md;
  bool get isLarge => this == ScreenSize.lg;

  double get value => switch (this) {
        (ScreenSize.xs) => ScreenConstants.smallWidth,
        (ScreenSize.md) => ScreenConstants.mediumWidth,
        (ScreenSize.lg) => ScreenConstants.largeWidth,
      };

  int get defaultCrossAxisCount => switch (this) {
        (ScreenSize.xs) => ScreenConstants.smallAxisCount,
        (ScreenSize.md) => ScreenConstants.mediumAxisCount,
        (ScreenSize.lg) => ScreenConstants.largeAxisCount,
      };

  static double get smallHeight => ScreenConstants.smallHeight;
}

extension MediaQueryExtension on BuildContext {
  ScreenSize get screenSize {
    final width = MediaQuery.sizeOf(this).width;
    if (width < ScreenSize.xs.value) return ScreenSize.xs;
    if (width < ScreenSize.md.value) return ScreenSize.md;

    return ScreenSize.lg;
  }

  bool get isSmallHeight =>
      MediaQuery.sizeOf(this).height < ScreenSize.smallHeight;
}

final class ScreenConstants {
  /// For mobile in landscape for non scrollable content
  static const smallHeight = 500.0;

  static const smallWidth = 600.0;
  static const mediumWidth = 900.0;
  static const largeWidth = 1200.0;

  static const smallAxisCount = 1;
  static const mediumAxisCount = 2;
  static const largeAxisCount = 3;

  ScreenConstants._();
}
