import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/immutable_list.dart';
import '../schools/school.dart';

part 'parade.mapper.dart';

typedef ParadeId = int;

@MappableClass()
class Parade with ParadeMappable {
  final ParadeId id;
  final SchoolId schoolId;
  final int carnivalId;
  final String carnivalName;
  final String enredo;
  final ImmutableList<String> carnavalescos;
  final String division;
  final SchoolDivision divisionNumber;
  final int? subdivisionNumber;
  final int paradeYear;
  final DateTime date;
  final DateTime? championParade;
  final int components;
  final int numberOfWings;
  final int numberOfFloats;
  final int numberOfTripods;
  final int performanceDay;
  final int placing;
  final bool relegated;
  final bool promoted;
  final bool champion;
  final int performanceOrder;
  final double points;
  final String details;
  final String translatedCarnivalName;
  final String translatedEnredo;
  final String translatedDivision;
  final ImmutableList<String> translatedCarnavalescos;
  final School school;

  static const fromMap = ParadeMapper.fromMap;
  static const fromJson = ParadeMapper.fromJson;

  Parade({
    required this.id,
    required this.schoolId,
    required this.carnivalId,
    required this.carnivalName,
    required this.enredo,
    required this.carnavalescos,
    required this.division,
    required this.divisionNumber,
    required this.subdivisionNumber,
    required this.paradeYear,
    required this.date,
    required this.championParade,
    required this.components,
    required this.numberOfWings,
    required this.numberOfFloats,
    required this.numberOfTripods,
    required this.placing,
    required this.relegated,
    required this.promoted,
    required this.champion,
    required this.performanceOrder,
    required this.performanceDay,
    required this.points,
    required this.details,
    required this.translatedCarnivalName,
    required this.translatedEnredo,
    required this.translatedDivision,
    required this.translatedCarnavalescos,
    required this.school,
  });
}

@MappableClass()
class ParadeQueryParams with ParadeQueryParamsMappable {
  final String? language;
  final String? filter;
  final String? sort;
  final String? sortOrder;
  final String? search;
  final int? page;
  final int? pageSize;

  ParadeQueryParams({
    this.language,
    this.filter,
    this.sort,
    this.sortOrder,
    this.search,
    this.page,
    this.pageSize,
  });
}
