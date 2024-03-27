import 'package:flutter/material.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_rail.dart';

const double smallScreen = 600;
const double smallHeight = 600;
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

  int getAxisCount([int small = 1, int large = 2, int extraLarge = 3]) {
    if (isSmallScreen || isMediumScreen) {
      return small;
    } else if (isLargeScreen) {
      return large;
    } else {
      return extraLarge;
    }
  }

  double get currentRailWidth {
    if (isSmallScreen) return 0;
    if (isMediumScreen) return AdaptiveNavigationRail.smallRailWidth;
    return AdaptiveNavigationRail.largeRailWidth;
  }
}
