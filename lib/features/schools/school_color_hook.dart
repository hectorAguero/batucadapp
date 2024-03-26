import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

class ColorHook extends MappingHook {
  const ColorHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) {
      final colorsNames = List<String>.from(value);
      return [
        for (final String color in colorsNames) _getColor(color),
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
        ('green' || 'verde' || 'verde' || 'みどり' || '緑') => Colors.green,
        ('light green' || 'verde claro' || 'verde claro' || 'うすみどり' || '浅緑') =>
          Colors.lightGreen,
        ('lime' || 'lima' || 'lima' || 'ライム' || 'ライム色') => Colors.lime,
        ('yellow' || 'amarelo' || 'amarillo' || 'きいろ' || '黄色') => Colors.yellow,
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
        ('black' || 'preto' || 'negro' || 'くろ' || '黒') => Colors.black,
        ('white' || 'branco' || 'blanco' || 'しろ' || '白') => Colors.white,
        // Add more colors as needed
        (_) => Colors.white // default case
      };
}
