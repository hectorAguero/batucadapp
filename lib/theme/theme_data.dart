import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => FlexThemeData.light(
        useMaterial3: true,
        keyColors: const FlexKeyColors(useSecondary: true),
        colors: const FlexSchemeColor(
          primary: Color(0xffff00a5),
          secondary: Color(0xff00a859),
        ),
        background: CupertinoColors.systemGroupedBackground,
        surface: CupertinoColors.systemBackground,
        subThemesData: const FlexSubThemesData(),
        splashFactory: InkSparkle.splashFactory,
      ).copyWith(
        cupertinoOverrideTheme: getCupertinoTheme(Brightness.light),
      );

  static ThemeData darkTheme({required bool trueBlack}) => FlexThemeData.dark(
        useMaterial3: true,
        keyColors: const FlexKeyColors(
          useSecondary: true,
        ),
        colors: const FlexSchemeColor(
          primary: Color(0xffff00a5),
          secondary: Color(0xff00a859),
        ),
        subThemesData: const FlexSubThemesData(),
        surface: CupertinoColors.systemBackground.darkColor,
        background: CupertinoColors.systemGroupedBackground.darkColor,
        splashFactory: InkSparkle.splashFactory,
        darkIsTrueBlack: trueBlack,
      ).copyWith(
        cupertinoOverrideTheme: getCupertinoTheme(Brightness.dark),
      );

  static CupertinoThemeData getCupertinoTheme(
    Brightness brightness,
  ) {
    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: const Color(0xffff00a5),
      barBackgroundColor: brightness == Brightness.dark
          ? CupertinoColors.systemBackground.darkColor
          : CupertinoColors.systemBackground.color,
      scaffoldBackgroundColor: brightness == Brightness.dark
          ? CupertinoColors.systemBackground.darkColor
          : CupertinoColors.systemBackground.color,
      textTheme: CupertinoTextThemeData(
        navLargeTitleTextStyle: const CupertinoThemeData()
            .textTheme
            .navLargeTitleTextStyle
            // fixes a small bug with spacing
            .copyWith(
              letterSpacing: -1.5,
            ),
      ),
    );
  }
}
