// This file is "model.dart"
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

// Will be generated by dart_mappable
part 'school.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum SchoolLeague { liesa, lierj, superliga }

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

@MappableClass(caseStyle: CaseStyle.snakeCase)
class School with SchoolMappable {
  const School({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.foundationDate,
    required this.godmotherSchool,
    required this.colors,
    required this.symbols,
    required this.league,
    required this.currentDivision,
    this.isFavorite = false,
  });

  final SchoolId id;
  final String name;
  final String imageUrl;
  @MappableField(hook: DateTimeHook())
  final DateTime foundationDate;
  final String godmotherSchool;
  @MappableField(hook: ColorHook())
  final List<Color> colors;
  final List<String> symbols;
  final SchoolLeague league;
  @MappableField(key: 'division_number')
  final SchoolDivision currentDivision;
  final bool isFavorite;
}

class ColorHook extends MappingHook {
  const ColorHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List<String>) {
      return [
        for (final Object color in value) _getColor(color),
      ];
    }
    return <Color>[];
  }

  Color _getColor(Object color) => switch (color.toString().toLowerCase()) {
        ('red' || 'vermelho' || 'rojo' || 'あか' || '赤') => Colors.red,
        ('pink' || 'rosa' || 'ピンク' || '桃色') => Colors.pink,
        ('purple' || 'roxo' || 'morado' || 'むらさき' || '紫') => Colors.purple,
        ('deep purple' ||
              'roxo escuro' ||
              'púrpura profundo' ||
              'こいむらさき' ||
              '濃紫') =>
          Colors.deepPurple,
        ('indigo' || 'índigo' || 'índigo' || 'インディゴ' || '藍色') => Colors.indigo,
        ('blue' || 'azul' || 'azul' || 'あお' || '青') => Colors.blue,
        ('light blue' || 'azul claro' || 'azul claro' || 'あおいろ' || '浅藍') =>
          Colors.lightBlue,
        ('cyan' || 'ciano' || 'cian' || 'みずいろ' || '水色') => Colors.cyan,
        ('teal' || 'verde azulado' || 'verde azulado' || 'アクア' || '青緑') =>
          Colors.teal,
        ('green' || 'verde' || 'verde' || 'みどり' || '緑') => Colors.green,
        ('light green' || 'verde claro' || 'verde claro' || 'うすみどり' || '浅緑') =>
          Colors.lightGreen,
        ('lime' || 'lima' || 'lima' || 'ライム' || 'ライム色') => Colors.lime,
        ('yellow' || 'amarelo' || 'amarillo' || 'きいろ' || '黄色') => Colors.yellow,
        ('amber' || 'âmbar' || 'ámbar' || 'こはくいろ' || '琥珀色') => Colors.amber,
        ('orange' || 'laranja' || 'naranja' || 'オレンジ' || '橙色') => Colors.orange,
        ('deep orange' ||
              'laranja escuro' ||
              'naranja oscuro' ||
              'だいだいいろ' ||
              '橙色') =>
          Colors.deepOrange,
        ('brown' || 'marrom' || 'marrón' || 'ちゃいろ' || '茶色') => Colors.brown,
        ('grey' || 'cinza' || 'gris' || 'はいいろ' || '灰色') => Colors.grey,
        ('blue grey' || 'azul cinza' || 'azul grisáceo' || 'あおはいいろ' || '藍灰色') =>
          Colors.blueGrey,
        ('black' || 'preto' || 'negro' || 'くろ' || '黒') => Colors.black,
        ('white' || 'branco' || 'blanco' || 'しろ' || '白') => Colors.white,
        ('celeste' || 'celeste' || 'celeste' || 'そらいろ' || '空色') =>
          Colors.lightBlue,
        // Add more colors as needed
        (_) => Colors.white // default case
      };
}

class DateTimeHook extends MappingHook {
  const DateTimeHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      //1946/6/24",
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
