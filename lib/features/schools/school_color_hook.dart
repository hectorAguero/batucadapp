import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import '../../utils/main_logger.dart';
import '../../utils/unmodifiable_list.dart';

class ColorHook extends MappingHook {
  const ColorHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) {
      return UnmodifiableList([
        for (final color in value) _getColor(color as String),
      ]);
    }
    return value;
  }

  Color _getColor(Object color) => switch (color.toString().toLowerCase()) {
        ('red' || 'vermelho' || 'rojo' || 'あか' || '赤' || 'レッド') => Colors.red,
        ('pink' || 'rosa' || 'ピンク' || '桃色') => Colors.pink,
        ('purple' || 'roxo' || 'morado' || 'むらさき' || '紫') => Colors.purple,
        ('deep purple' ||
              'roxo escuro' ||
              'púrpura profundo' ||
              'こいむらさき' ||
              '濃紫') =>
          Colors.deepPurple,
        ('indigo' || 'índigo' || 'índigo' || 'インディゴ' || '藍色') => Colors.indigo,
        ('blue' ||
              'navy blue' ||
              'azul' ||
              'azul' ||
              'azul marino' ||
              'あお' ||
              'ネイビーブルー' ||
              'ブルー' ||
              '青') =>
          Colors.blue,
        ('light blue' || 'azul claro' || 'azul claro' || 'あおいろ' || '浅藍') =>
          Colors.lightBlue,
        ('cyan' ||
              'peacock blue' ||
              'azul-pavo' ||
              'ciano' ||
              'cian' ||
              'みずいろ' ||
              '水色' ||
              'ピーコック・ブルー') =>
          Colors.cyan,
        ('teal' || 'verde azulado' || 'verde azulado' || 'アクア' || '青緑') =>
          Colors.teal,
        ('green' || 'verde' || 'verde' || 'みどり' || '緑' || 'グリーン') =>
          Colors.green,
        ('light green' || 'verde claro' || 'verde claro' || 'うすみどり' || '浅緑') =>
          Colors.lightGreen,
        ('lime' || 'lima' || 'lima' || 'ライム' || 'ライム色') => Colors.lime,
        ('yellow' || 'amarelo' || 'amarillo' || 'きいろ' || '黄色' || 'イエロー') =>
          Colors.yellow,
        ('amber' || 'âmbar' || 'ámbar' || 'こはくいろ' || '琥珀色') => Colors.amber,
        ('gold' || 'oro' || 'ouro' || 'ゴールド') => Colors.amber,
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
        ('black' || 'preto' || 'negro' || 'くろ' || 'ブラック' || '黒') =>
          Colors.black,
        ('white' || 'branco' || 'blanco' || 'しろ' || '白' || 'ホワイト') =>
          Colors.white,
        // Add more colors as needed
        (_) => _defaultColor(color.toString()) // default case
      };
}

Color _defaultColor(String color) {
  logParserColor.info('Color not parsed $color');
  return Colors.white;
}
