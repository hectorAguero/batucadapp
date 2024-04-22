/// Schools of Samba of Rio de Janeiro
library;

import 'package:flutter/material.dart';
import '../../core/extensions/app_localization_extension.dart';
import '../../core/extensions/string_extensions.dart';
import 'school.dart';

extension SchoolExtensions on School {
  bool searchLogic(String search) {
    if (name.removeAccents.contains(search)) {
      return true;
    }
    if (symbols.join(' ').removeAccents.contains(search)) {
      return true;
    }

    if (godmotherSchool.removeAccents.contains(search)) {
      return true;
    }

    if (colorsCode.join(' ').removeAccents.contains(search)) {
      return true;
    }

    return false;
  }
}

extension SchoolDivisionExtension on SchoolDivision {
  String fullName(BuildContext context) => switch (this) {
        (SchoolDivision.especial) => context.loc.schoolDivisionSpecialFullName,
        (SchoolDivision.ouro) => context.loc.schoolDivisionGoldFullName,
        (SchoolDivision.prata) => context.loc.schoolDivisionSilverFullName,
        (SchoolDivision.bronze) => context.loc.schoolDivisionBronzeFullName,
        (SchoolDivision.avaliacao) =>
          context.loc.schoolDivisionEvaluationFullName,
        (SchoolDivision.mirins) => context.loc.schoolDivisionChildrenFullName,
        (SchoolDivision.blocosDeEnredo1) =>
          context.loc.schoolDivisionEnredoBloco1,
        (SchoolDivision.blocosDeEnredo2) =>
          context.loc.schoolDivisionEnredoBloco2,
        (SchoolDivision.blocosDeRua) => context.loc.schoolDivisionStreetBloco,
      };

  String shortName(BuildContext context) => switch (this) {
        (SchoolDivision.especial) => context.loc.schoolDivisionSpecial,
        (SchoolDivision.ouro) => context.loc.schoolDivisionGold,
        (SchoolDivision.prata) => context.loc.schoolDivisionSilver,
        (SchoolDivision.bronze) => context.loc.schoolDivisionBronze,
        (SchoolDivision.avaliacao) => context.loc.schoolDivisionEvaluation,
        (SchoolDivision.mirins) => context.loc.schoolDivisionChildren,
        (SchoolDivision.blocosDeEnredo1) =>
          context.loc.schoolDivisionEnredoBloco1,
        (SchoolDivision.blocosDeEnredo2) =>
          context.loc.schoolDivisionEnredoBloco2,
        (SchoolDivision.blocosDeRua) => context.loc.schoolDivisionStreetBloco,
      };
}
