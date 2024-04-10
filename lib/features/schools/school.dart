// This file is "model.dart"

import 'dart:collection';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

import '../../utils/unmodifiable_list.dart';
import 'school_color_hook.dart';

// Will be generated by dart_mappable
part 'school.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum SchoolLeague { liesa, ligarj, superliga, acas }

@MappableEnum()
enum SchoolDivision {
  @MappableValue(1)
  especial,
  @MappableValue(2)
  ouro,
  @MappableValue(3)
  prata,
  @MappableValue(4)
  bronze,
  @MappableValue(5)
  avaliacao,
  @MappableValue(6)
  mirins
}

typedef SchoolId = int;

@MappableClass()
class School with SchoolMappable {
  const School({
    required this.id,
    required this.name,
    required this.translatedName,
    required this.imageUrl,
    required this.foundationDate,
    required this.godmotherSchool,
    required this.colorNames,
    required this.colors,
    required this.symbols,
    required this.league,
    required this.currentDivision,
    required this.divisionNumber,
    required this.firstDivisionChampionships,
    required this.country,
    required this.leagueLocation,
    required this.lastPosition,
    required this.translatedColorNames,
    required this.translatedSymbols,
    required this.translatedGodmotherSchool,
    required this.translatedLeagueLocation,
    required this.translatedCountry,
  });

  final SchoolId id;
  final String name;
  final String imageUrl;
  @MappableField(hook: DateTimeHook())
  final DateTime foundationDate;
  final String godmotherSchool;
  @MappableField(key: 'colors')
  final UnmodifiableList<String> colorNames;
  @MappableField(hook: ColorHook())
  final UnmodifiableList<Color> colors;
  final UnmodifiableList<String> symbols;
  final SchoolLeague league;
  @MappableField(key: 'divisionNumber')
  final SchoolDivision currentDivision;
  final int divisionNumber;
  final int firstDivisionChampionships;
  final String country;
  final String leagueLocation;
  final int lastPosition;
  final String translatedName;
  @MappableField(key: 'translatedColors')
  final UnmodifiableList<String> translatedColorNames;
  final UnmodifiableList<String> translatedSymbols;
  final String translatedGodmotherSchool;
  final String translatedLeagueLocation;
  final String translatedCountry;

  static const fromMap = SchoolMapper.fromMap;
  static const fromJson = SchoolMapper.fromJson;
}

class DateTimeHook extends MappingHook {
  const DateTimeHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      //1946/6/24
      final data = value.split('/');
      return DateTime(
        int.parse(data.first),
        int.parse(data[1]),
        int.parse(data.last),
      );
    }
    throw Exception('Date is not valid');
  }
}
