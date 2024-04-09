import 'dart:collection';

import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/unmodifiable_list.dart';
import '../schools/school.dart';

part 'parade.mapper.dart';

typedef ParadeId = int;

@MappableClass()
class Parade with ParadeMappable {
  Parade({
    required this.id,
    required this.carnivalName,
    required this.enredo,
    required this.carnavalescos,
    required this.division,
    required this.schoolId,
    required this.divisionNumber,
    required this.paradeYear,
    required this.date,
    required this.championParade,
    required this.components,
    required this.numberOfWings,
    required this.numberOfFloats,
    required this.numberOfTripods,
    required this.placing,
    required this.relegated,
    required this.performanceOrder,
    required this.points,
    required this.translatedCarnivalName,
    required this.translatedEnredo,
    required this.translatedDivision,
    required this.translatedCarnavalescos,
    required this.school,
  });

  final ParadeId id;
  final String carnivalName;
  final String enredo;
  final UnmodifiableList<String> carnavalescos;
  final String division;
  final SchoolId schoolId;
  final SchoolDivision divisionNumber;
  final int paradeYear;
  final DateTime date;
  final DateTime? championParade;
  final int components;
  final int numberOfWings;
  final int numberOfFloats;
  final int numberOfTripods;
  final int placing;
  final bool relegated;
  final int performanceOrder;
  final double points;
  final String translatedCarnivalName;
  final String translatedEnredo;
  final String translatedDivision;
  final UnmodifiableList<String> translatedCarnavalescos;
  final School? school;

  static const fromMap = ParadeMapper.fromMap;
  static const fromJson = ParadeMapper.fromJson;
}

class ParadeQueryParams {
  ParadeQueryParams({
    this.language,
    this.filter,
    this.sort,
    this.sortOrder,
    this.page,
    this.pageSize,
  });

  final String? language;
  final String? filter;
  final String? sort;
  final String? sortOrder;
  final int? page;
  final int? pageSize;
}
