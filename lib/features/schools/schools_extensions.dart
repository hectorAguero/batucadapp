/// Schools of Samba of Rio de Janeiro
library;

import 'package:flutter/material.dart';
import 'package:samba_public_app/features/schools/school.dart';

extension SchoolDivisionExtension on SchoolDivision {
  String get fullName => switch (this) {
        (SchoolDivision.especial) => 'Grupo Especial',
        (SchoolDivision.ouro) => 'Série Ouro',
        (SchoolDivision.prata) => 'Série Prata',
        (SchoolDivision.bronze) => 'Série Bronze',
        (SchoolDivision.avaliacao) => 'Grupo de Avaliação',
        (SchoolDivision.mirins) => 'Mirins',
      };

  String get shortName => switch (this) {
        (SchoolDivision.especial) => 'Especial',
        (SchoolDivision.ouro) => 'Ouro',
        (SchoolDivision.prata) => 'Prata',
        (SchoolDivision.bronze) => 'Bronze',
        (SchoolDivision.avaliacao) => 'Avaliação',
        (SchoolDivision.mirins) => 'Mirins',
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
          SchoolLeague.lierj,
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
