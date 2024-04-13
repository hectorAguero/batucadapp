import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

import '../../utils/immutable_list.dart';
import '../../utils/main_logger.dart';

class ColorHook extends MappingHook {
  const ColorHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) {
      return ImmutableList([
        for (final color in value) _getColor(color as String),
      ]);
    }
    return value;
  }

  Color _getColor(Object color) {
    return switch (color.toString().replaceAll('-', ' ').toLowerCase()) {
      'anil' => Colors.indigo,
      'vermelho' => Colors.red,
      'rosa' => Colors.pink,
      'roxo' || 'morado' => Colors.purple,
      'roxo escuro' || 'púrpura profundo' => Colors.deepPurple,
      'indigo' || 'índigo' => Colors.indigo,
      'azul' => Colors.blue,
      'azul claro' => Colors.lightBlue,
      'azul pavo' || 'ciano' => Colors.cyan,
      'verde azulado' => Colors.teal,
      'verde' => Colors.green,
      'verde claro' => Colors.lightGreen,
      'lima' => Colors.lime,
      'amarelo' => Colors.yellow,
      'amber' || 'âmbar' || 'ámbar' || 'amarelo ouro' => Colors.amber,
      'ouro' || 'dourado' => Colors.amber,
      'laranja' => Colors.orange,
      'laranja escuro' => Colors.deepOrange,
      'marrom' => Colors.brown,
      'cinza' => Colors.grey,
      'azul grisáceo' => Colors.blueGrey,
      'preto' || 'negro' => Colors.black,
      'branco' => Colors.white,
      'azul marinho' => Colors.blue.shade900,
      'azul pavão' => Colors.cyan,
      'azul royal' => Colors.blue.shade800,
      'azul turquesa' => Colors.cyan.shade400,
      'violeta' => Colors.purple.shade800,
      'prata' => Colors.grey.shade400,
      'encarnado' => Colors.red.shade700,
      'azul escuro' => Colors.blue.shade800,
      _ => _defaultColor(color.toString())
    };
  }

  Color _defaultColor(String color) {
    logColorParse.info('Color not parsed $color');
    return Colors.white;
  }
}
