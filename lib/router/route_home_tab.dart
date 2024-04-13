import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteHomeTab {
  RouteHomeTab({
    required this.path,
    required this.builder,
    this.routes = const [],
  });

  final String path;
  final Widget Function(BuildContext, GoRouterState, ScrollController) builder;
  final List<RouteBase> routes;

  String addPathParameters(Map<String, String> parameters) {
    var newPath = path;
    for (final entry in parameters.entries) {
      newPath = newPath.replaceAll(':${entry.key}', entry.value);
    }
    return newPath;
  }
}
