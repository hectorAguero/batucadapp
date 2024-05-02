import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

import '../../utils/app_loggers.dart';
import '../../utils/immutable_list.dart';

class SchoolColorHook extends MappingHook {
  const SchoolColorHook();

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
      'anil' => Colors.indigo.shade500,
      'vermelho' => Colors.red.shade500,
      'rosa' => Colors.pink.shade500,
      'roxo' || 'morado' => Colors.purple.shade500,
      'roxo escuro' || 'púrpura profundo' => Colors.deepPurple.shade500,
      'indigo' || 'índigo' => Colors.indigo.shade500,
      'azul' => Colors.blue.shade500,
      'azul claro' => Colors.lightBlue.shade500,
      'azul pavo' || 'ciano' => Colors.cyan.shade500,
      'verde azulado' => Colors.teal.shade500,
      'verde' => Colors.green.shade500,
      'verde claro' => Colors.lightGreen.shade500,
      'lima' => Colors.lime.shade500,
      'amarelo' => Colors.yellow.shade500,
      'amber' || 'âmbar' || 'ámbar' || 'amarelo ouro' => Colors.amber.shade500,
      'ouro' || 'dourado' => Colors.amber.shade500,
      'laranja' => Colors.orange.shade500,
      'laranja escuro' => Colors.deepOrange.shade500,
      'marrom' => Colors.brown.shade500,
      'cinza' => Colors.grey.shade500,
      'azul grisáceo' => Colors.blueGrey.shade500,
      'preto' || 'negro' => Colors.black,
      'branco' => Colors.white,
      'azul marinho' => Colors.blue.shade900,
      'azul pavão' => Colors.cyan.shade500,
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
