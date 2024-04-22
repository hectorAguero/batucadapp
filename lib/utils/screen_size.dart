import 'package:flutter/material.dart';

/// For mobile in landscape for non scrollable content
const _smallHeight = 500.0;

const _smallWidth = 600.0;
const _mediumWidth = 900.0;
const _largeWidth = 1200.0;

const _smallAxisCount = 1;
const _mediumAxisCount = 2;
const _largeAxisCount = 3;

enum ScreenSize {
  xs,
  md,
  lg;

  bool get isSmall => this == ScreenSize.xs;
  bool get isMedium => this == ScreenSize.md;
  bool get isLarge => this == ScreenSize.lg;

  double get value => switch (this) {
        (ScreenSize.xs) => _smallWidth,
        (ScreenSize.md) => _mediumWidth,
        (ScreenSize.lg) => _largeWidth,
      };

  int get defaultCrossAxisCount => switch (this) {
        (ScreenSize.xs) => _smallAxisCount,
        (ScreenSize.md) => _mediumAxisCount,
        (ScreenSize.lg) => _largeAxisCount,
      };

  static double get smallHeight => _smallHeight;
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
