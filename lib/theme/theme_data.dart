import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffff00a5),
          secondary: const Color(0xff00a859),
          background: CupertinoColors.systemGroupedBackground,
        ),
      ).copyWith(
        splashFactory: InkSparkle.splashFactory,
        cupertinoOverrideTheme: getCupertinoTheme(Brightness.light),
      );

  static ThemeData get darkTheme => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xffff00a5),
          secondary: const Color(0xff00a859),
          background: CupertinoColors.systemBackground.darkColor,
        ),
      ).copyWith(
        splashFactory: InkSparkle.splashFactory,
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
