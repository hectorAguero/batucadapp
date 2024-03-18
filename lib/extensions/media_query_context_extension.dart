import 'package:flutter/material.dart';

const double smallScreen = 600;
const double mediumScreen = 900;
const double largeScreen = 1200;
const double extraLargeScreen = 1536;

extension MediaQueryExtension on BuildContext {
  Size get querySize => MediaQuery.sizeOf(this);
}

extension ScreenSizeExtension on Size {
  bool get isSmallScreen => width < smallScreen;

  bool get isMediumScreen => width >= smallScreen && width < mediumScreen;

  bool get isLargeScreen => width >= mediumScreen && width < largeScreen;

  bool get isExtraLargeScreen => width >= largeScreen;

  int getAxisCount([int small = 1, int mediumLarge = 2, int extraLarge = 3]) {
    if (isSmallScreen) {
      return small;
    } else if (isMediumScreen || isLargeScreen) {
      return mediumLarge;
    } else {
      return extraLarge;
    }
  }
}
