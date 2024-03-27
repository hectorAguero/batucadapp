/// Schools of Samba of Rio de Janeiro
library;

import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/string_extension.dart';
import 'package:samba_public_app/features/schools/school.dart';

extension SchoolLeagueExtension on SchoolLeague {
  String fullName(BuildContext context) => switch (this) {
        (SchoolLeague.liesa) => context.loc.schoolLeagueLiesaFullName,
        (SchoolLeague.ligarj) => context.loc.schoolLeagueLigarjFullName,
        (SchoolLeague.superliga) => context.loc.schoolLeagueSuperligaFullName,
        (SchoolLeague.acas) => context.loc.schoolLeagueAcasFullName,
      };
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
      };

  String shortName(BuildContext context) => switch (this) {
        (SchoolDivision.especial) => context.loc.schoolDivisionSpecial,
        (SchoolDivision.ouro) => context.loc.schoolDivisionGold,
        (SchoolDivision.prata) => context.loc.schoolDivisionSilver,
        (SchoolDivision.bronze) => context.loc.schoolDivisionBronze,
        (SchoolDivision.avaliacao) => context.loc.schoolDivisionEvaluation,
        (SchoolDivision.mirins) => context.loc.schoolDivisionChildren,
      };
}

extension SearchLogicSchoolExtension on School {
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

    if (colorNames.join(' ').removeAccents.contains(search)) {
      return true;
    }

    return false;
  }
}
