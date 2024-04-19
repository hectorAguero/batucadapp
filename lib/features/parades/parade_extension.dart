import 'package:flutter/material.dart';

import '../../core/extensions/theme_of_context_extension.dart';
import '../schools/school.dart';
import 'parade.dart';

extension ParadeExtension on Parade {
  String get getPerformanceIcon => divisionNumber == SchoolDivision.especial
      ? _firstDivisionIcon
      : _otherDivisionIcon;

  String get _firstDivisionIcon => switch ((placing, relegated, champion)) {
        (1, _, _) => '🏆',
        (2, _, _) => '🥈',
        (3, _, _) => '🥉',
        (4 || 5 || 6, _, false) => '🏅',
        (_, true, _) => '🔻',
        _ => '🎗️',
      };

  String get _otherDivisionIcon => switch ((placing, relegated, champion)) {
        (1, _, true) => '🏆',
        (1, _, false) => '🥇',
        (2, _, _) => '🥈',
        (3, _, _) => '🥉',
        (_, true, _) => '🔻',
        _ => '🎗️',
      };

  Color medalColor(BuildContext context) {
    return divisionNumber == SchoolDivision.especial
        ? _specialMedalColor(context)
        : _otherMedalColor(context);
  }

  Color _otherMedalColor(BuildContext context) {
    return switch ((
      placing: placing,
      relegated: relegated,
      promoted: promoted,
      champion: champion
    )) {
      (placing: 1, relegated: _, promoted: _, champion: true) =>
        context.customColors.goldColor!,
      (placing: 1, relegated: _, promoted: true, champion: false) =>
        context.customColors.silverColor!,
      (placing: 2, relegated: _, promoted: true, champion: _) =>
        context.customColors.silverColor!,
      (placing: 2 || 3 || 4 || 5, relegated: _, promoted: true, champion: _) =>
        context.colorScheme.secondary,
      (placing: _, relegated: true, promoted: _, champion: _) =>
        context.colorScheme.errorContainer,
      _ => context.colorScheme.primaryContainer,
    };
  }

  Color _specialMedalColor(BuildContext context) {
    return switch ((placing: placing, relegated: relegated)) {
      (placing: 1, relegated: _) => context.customColors.goldColor!,
      (placing: 2, relegated: _) => context.customColors.silverColor!,
      (placing: 3 || 4 || 5 || 6, relegated: _) =>
        context.colorScheme.tertiaryContainer,
      (placing: _, relegated: true) => context.colorScheme.errorContainer,
      _ => context.colorScheme.primaryContainer,
    };
  }
}
