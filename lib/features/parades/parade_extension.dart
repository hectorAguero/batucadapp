import 'package:flutter/material.dart';

import '../../core/extensions/theme_of_context_extension.dart';
import '../schools/school.dart';
import 'parade.dart';

const int _firstPlacing = 1;
const int _secondPlacing = 2;
const int _thirdPlacing = 3;
const int _fourthPlacing = 4;
const int _fifthPlacing = 5;
const int _sixthPlacing = 6;

extension ParadeExtension on Parade {
  String get getPerformanceIcon => divisionNumber == SchoolDivision.especial
      ? _firstDivisionIcon
      : _otherDivisionIcon;

  String get _firstDivisionIcon => switch ((placing, relegated, champion)) {
        (_firstPlacing, _, _) => '🏆',
        (_secondPlacing, _, _) => '🥈',
        (_thirdPlacing, _, _) => '🥉',
        (_fourthPlacing || _fifthPlacing || _sixthPlacing, _, false) => '🏅',
        (_, true, _) => '🔻',
        _ => '🎗️',
      };

  String get _otherDivisionIcon => switch ((placing, relegated, champion)) {
        (1, _, true) => '🏆',
        (1, _, false) => '🥇',
        (_secondPlacing, _, _) => '🥈',
        (_thirdPlacing, _, _) => '🥉',
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
      (placing: _firstPlacing, relegated: _, promoted: _, champion: true) =>
        context.customGoldColor,
      (placing: _firstPlacing, relegated: _, promoted: true, champion: false) =>
        context.customSilverColor,
      (placing: _secondPlacing, relegated: _, promoted: true, champion: _) =>
        context.customSilverColor,
      (
        placing:
            _secondPlacing || _thirdPlacing || _fourthPlacing || _fifthPlacing,
        relegated: _,
        promoted: true,
        champion: _
      ) =>
        context.colorScheme.secondary,
      (placing: _, relegated: true, promoted: _, champion: _) =>
        context.colorScheme.errorContainer,
      _ => context.colorScheme.primaryContainer,
    };
  }

  Color _specialMedalColor(BuildContext context) {
    return switch ((placing: placing, relegated: relegated)) {
      (placing: _firstPlacing, relegated: _) => context.customGoldColor,
      (placing: _secondPlacing, relegated: _) => context.customSilverColor,
      (
        placing:
            _thirdPlacing || _fourthPlacing || _fifthPlacing || _sixthPlacing,
        relegated: _
      ) =>
        context.colorScheme.tertiaryContainer,
      (placing: _, relegated: true) => context.colorScheme.errorContainer,
      _ => context.colorScheme.primaryContainer,
    };
  }
}
