/// Schools of Samba of Rio de Janeiro
library;

import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/string_extension.dart';
import 'package:samba_public_app/features/schools/school.dart';

extension SchoolLeagueExtension on SchoolLeague {
  String get fullName => switch (this) {
        (SchoolLeague.liesa) =>
          'Liga Independente das Escolas de Samba'.hardcoded,
        (SchoolLeague.ligarj) =>
          'Liga das Escolas de Samba do Rio de Janeiro'.hardcoded,
        (SchoolLeague.superliga) => 'Superliga das Escolas de Samba'.hardcoded,
        (SchoolLeague.acas) =>
          'Associação Cultural das Escolas de Samba'.hardcoded,
      };
}

extension SchoolDivisionExtension on SchoolDivision {
  String get fullName => switch (this) {
        (SchoolDivision.especial) => 'Grupo Especial'.hardcoded,
        (SchoolDivision.ouro) => 'Série Ouro'.hardcoded,
        (SchoolDivision.prata) => 'Série Prata'.hardcoded,
        (SchoolDivision.bronze) => 'Série Bronze'.hardcoded,
        (SchoolDivision.avaliacao) => 'Grupo de Avaliação'.hardcoded,
        (SchoolDivision.mirins) => 'Mirins'.hardcoded,
      };

  String get shortName => switch (this) {
        (SchoolDivision.especial) => 'Especial'.hardcoded,
        (SchoolDivision.ouro) => 'Ouro'.hardcoded,
        (SchoolDivision.prata) => 'Prata'.hardcoded,
        (SchoolDivision.bronze) => 'Bronze'.hardcoded,
        (SchoolDivision.avaliacao) => 'Avaliação'.hardcoded,
        (SchoolDivision.mirins) => 'Mirins'.hardcoded,
      };

  Color get color => switch (this) {
        (SchoolDivision.especial) => Colors.red,
        (SchoolDivision.ouro) => Colors.yellow,
        (SchoolDivision.prata) => Colors.blue,
        (SchoolDivision.bronze) => Colors.brown,
        (SchoolDivision.avaliacao) => Colors.green,
        (SchoolDivision.mirins) => Colors.purple,
      };

  String get place => switch (this) {
        (SchoolDivision.especial ||
              SchoolDivision.ouro ||
              SchoolDivision.mirins) =>
          'Sambódromo',
        (_) => 'Intendente Magalhães',
      };

  SchoolLeague get league => switch (this) {
        (SchoolDivision.especial ||
              SchoolDivision.ouro ||
              SchoolDivision.mirins) =>
          SchoolLeague.liesa,
        (SchoolDivision.prata ||
              SchoolDivision.bronze ||
              SchoolDivision.avaliacao) =>
          SchoolLeague.superliga,
      };

  int get divisionNumber => switch (this) {
        (SchoolDivision.especial) => 1,
        (SchoolDivision.ouro) => 2,
        (SchoolDivision.prata) => 3,
        (SchoolDivision.bronze) => 4,
        (SchoolDivision.avaliacao) => 5,
        (SchoolDivision.mirins) => 6,
      };
}

extension SearchLogicSchoolExtension on School {
  bool searchLogic(String search) {
    if (name.removeAccents.contains(search)) {
      return true;
    }
    // TODO: Add more search logic

    return false;
  }
}
