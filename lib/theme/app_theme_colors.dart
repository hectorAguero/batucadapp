import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

part 'app_theme_colors.mapper.dart';

@MappableClass(includeCustomMappers: [ColorMapper()])
class AppThemeColors with AppThemeColorsMappable {
  final Color primary;
  final Color? secondary;
  final Color? tertiary;
  final String name;

  static const fromMap = AppThemeColorsMapper.fromMap;
  static const fromJson = AppThemeColorsMapper.fromJson;

  AppThemeColors({
    required this.primary,
    required this.name,
    this.secondary,
    this.tertiary,
  });

  AppThemeColors.defaultColors()
      : primary = const Color(0xffff00a5),
        name = Constants.defaultColorName,
        secondary = const Color(0xff00a859),
        tertiary = null;
}

extension AppColorsExtension on AppThemeColors {
  int get usedColors {
    return (secondary != null ? 1 : 0) + (tertiary != null ? 1 : 0) + 1;
  }
}

class ColorMapper extends SimpleMapper<Color> {
  const ColorMapper();

  @override
  Color decode(dynamic value) {
    if (value is int) {
      return Color(value);
    }

    return Color(int.parse(value.toString()));
  }

  @override
  dynamic encode(Color self) {
    return self.value;
  }
}
