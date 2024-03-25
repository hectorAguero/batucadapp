// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
        subThemesData: const FlexSubThemesData(
          tooltipSchemeColor: SchemeColor.inverseSurface,
        ),
        splashFactory: InkSparkle.splashFactory,
        extensions: [
          AppColorTextTheme.light(),
          const WoltModalSheetThemeData(
            bottomSheetShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            dialogShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
          ),
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
        ),
        surface: CupertinoColors.systemBackground.darkColor,
        background: CupertinoColors.systemGroupedBackground.darkColor,
        splashFactory: InkSparkle.splashFactory,
        darkIsTrueBlack: trueBlack,
        extensions: [
          AppColorTextTheme.dark(),
          const WoltModalSheetThemeData(
            bottomSheetShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
            dialogShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(28),
              ),
            ),
          ),
        ],
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

class AppColorTextTheme extends ThemeExtension<AppColorTextTheme> {
  final Color? textColor;

  final Color? inverseTextColor;

  AppColorTextTheme({
    required this.textColor,
    required this.inverseTextColor,
  });

  AppColorTextTheme.light()
      : textColor = const Color(0xff000000),
        inverseTextColor = const Color(0xffffffff);

  AppColorTextTheme.dark()
      : textColor = const Color(0xffffffff),
        inverseTextColor = const Color(0xff000000);

  @override
  AppColorTextTheme copyWith({
    Color? appTextColor,
    Color? appInverseTextColor,
  }) {
    return AppColorTextTheme(
      textColor: appTextColor ?? textColor,
      inverseTextColor: appInverseTextColor ?? inverseTextColor,
    );
  }

  @override
  AppColorTextTheme lerp(AppColorTextTheme? other, double t) {
    if (other is! AppColorTextTheme) {
      return this;
    }
    return AppColorTextTheme(
      textColor: Color.lerp(textColor, other.textColor, t),
      inverseTextColor: Color.lerp(inverseTextColor, other.inverseTextColor, t),
    );
  }
}

extension ThemeDataExtension on ThemeData {
  AppColorTextTheme get colorTheme => extension<AppColorTextTheme>()!;
}
