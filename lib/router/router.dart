import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/features/home/home_page.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/features/instruments/instruments_tab.dart';
import 'package:samba_public_app/features/parades/parades_tab.dart';
import 'package:samba_public_app/features/schools/schools_tab.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

enum _HomeTab {
  instruments,
  parades,
  schools;

  String get path => switch (this) {
        _HomeTab.instruments => InstrumentsTab.route.path,
        _HomeTab.parades => ParadesTab.route.path,
        _HomeTab.schools => SchoolsTab.route.path,
      };
}

class AppBaseRoute {
  const AppBaseRoute({
    required this.path,
    required this.builder,
    this.routes = const <RouteBase>[],
  });

  final String path;
  final Widget Function(BuildContext, GoRouterState, ScrollController) builder;
  final List<RouteBase> routes;
}

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final primaryScrolls = List.generate(
      _HomeTab.values.length,
      (_) => ScrollController(),
    );
    final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        if (_HomeTab.values.any((tab) => tab.path == state.uri.toString())) {
          final currentIndex = ref.read(selectedHomeTabIndexProvider);
          final newIndex = _HomeTab.values.indexWhere(
            (tab) => tab.path == state.uri.toString(),
          );
          if (currentIndex != newIndex) {
            ref.read(selectedHomeTabIndexProvider.notifier).select(newIndex);
          } else {
            _checkScrollController(
              primaryScrolls[newIndex],
              state,
            );
          }
        }
        return null;
      },
      initialLocation: InstrumentsTab.route.path,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              HomePage(navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: InstrumentsTab.route.path,
                  builder: (context, state) => InstrumentsTab.route.builder(
                    context,
                    state,
                    primaryScrolls[0], // InstrumentsTab
                  ),
                  routes: InstrumentsTab.route.routes,
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: ParadesTab.route.path,
                  builder: (context, state) => ParadesTab.route.builder(
                    context,
                    state,
                    primaryScrolls[1], // ParadesTab
                  ),
                  routes: ParadesTab.route.routes,
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: SchoolsTab.route.path,
                  builder: (context, state) => SchoolsTab.route.builder(
                    context,
                    state,
                    primaryScrolls[2],
                  ),
                  routes: SchoolsTab.route.routes,
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return router;
  },
);

void _checkScrollController(ScrollController controller, GoRouterState state) {
  if (controller.hasClients) {
    controller.animateTo(
      0,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }
}
