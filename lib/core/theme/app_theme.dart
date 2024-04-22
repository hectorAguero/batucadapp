// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _iOSFontLetterSpacing = -1.5;

class AppTheme {
  static ThemeData get lightTheme => FlexThemeData.light(
        useMaterial3: true,
        keyColors: const FlexKeyColors(
          useSecondary: true,
        ),
        colors: const FlexSchemeColor(
          primary: Color(0xffff00a5),
          secondary: Color(0xff00a859),
        ),
        background: CupertinoColors.systemGroupedBackground,
        surface: CupertinoColors.systemBackground,
        subThemesData: const FlexSubThemesData(
          tooltipSchemeColor: SchemeColor.inverseSurface,
          adaptiveSplash: FlexAdaptive.appleWeb(),
          chipSchemeColor: SchemeColor.surface,
          snackBarBackgroundSchemeColor: SchemeColor.inversePrimary,
          snackBarRadius: 8,
          snackBarElevation: 2,
          bottomSheetRadius: 16,
          bottomSheetModalBackgroundColor: SchemeColor.background,
        ),
        splashFactory: InkSparkle.splashFactory,
        extensions: [
          AppCustomColors.light(),
        ],
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
        subThemesData: const FlexSubThemesData(
          tooltipSchemeColor: SchemeColor.inverseSurface,
          adaptiveSplash: FlexAdaptive.apple(),
          chipSchemeColor: SchemeColor.surfaceTint,
          snackBarBackgroundSchemeColor: SchemeColor.inversePrimary,
          snackBarRadius: 8,
          snackBarElevation: 2,
          bottomSheetRadius: 16,
          bottomSheetModalBackgroundColor: SchemeColor.background,
        ),
        surface: CupertinoColors.systemBackground.darkColor,
        background: CupertinoColors.systemGroupedBackground.darkColor,
        splashFactory: InkSparkle.splashFactory,
        darkIsTrueBlack: trueBlack,
        extensions: [AppCustomColors.dark()],
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
              letterSpacing: _iOSFontLetterSpacing,
            ),
      ),
    );
  }
}

class AppCustomColors extends ThemeExtension<AppCustomColors> {
  final Color? textColor;
  final Color? inverseTextColor;
  final Color? goldColor;
  final Color? silverColor;
  final Color? bronzeColor;

  AppCustomColors({
    required this.textColor,
    required this.inverseTextColor,
    required this.goldColor,
    required this.silverColor,
    required this.bronzeColor,
  });

  AppCustomColors.light()
      : textColor = const Color(0xff000000),
        goldColor = const Color(0xFFFBC02D),
        silverColor = const Color(0xffc0c0c0),
        bronzeColor = const Color(0xffcd7f32),
        inverseTextColor = const Color(0xffffffff);

  AppCustomColors.dark()
      : textColor = const Color(0xffffffff),
        goldColor = const Color(0xffd4af37),
        silverColor = const Color(0xffa9a9a9),
        bronzeColor = const Color(0xff8b4513),
        inverseTextColor = const Color(0xff000000);

  @override
  AppCustomColors copyWith({
    Color? appTextColor,
    Color? appInverseTextColor,
  }) {
    return AppCustomColors(
      textColor: appTextColor ?? textColor,
      inverseTextColor: appInverseTextColor ?? inverseTextColor,
      goldColor: goldColor,
      silverColor: silverColor,
      bronzeColor: bronzeColor,
    );
  }

  @override
  AppCustomColors lerp(AppCustomColors? other, double t) {
    if (other is! AppCustomColors) {
      return this;
    }

    return AppCustomColors(
      textColor: Color.lerp(textColor, other.textColor, t),
      inverseTextColor: Color.lerp(inverseTextColor, other.inverseTextColor, t),
      goldColor: Color.lerp(goldColor, other.goldColor, t),
      silverColor: Color.lerp(silverColor, other.silverColor, t),
      bronzeColor: Color.lerp(bronzeColor, other.bronzeColor, t),
    );
  }
}
