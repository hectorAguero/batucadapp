import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/unmodifiable_list.dart';

class GoRouteScrollTab {
  GoRouteScrollTab({
    required this.path,
    required this.builder,
    //UnmodifiableList routes = = const <RouteBase>[], // Because this doesnt work
    UnmodifiableList<RouteBase>? routes,
  }) : routes = UnmodifiableList(routes ?? []);

  final String path;
  final Widget Function(BuildContext, GoRouterState, ScrollController) builder;
  final UnmodifiableList<RouteBase> routes;

  String addPathParameters(Map<String, String> parameters) {
    var newPath = path;
    for (final entry in parameters.entries) {
      newPath = newPath.replaceAll(':${entry.key}', entry.value);
    }
    return newPath;
  }
}
