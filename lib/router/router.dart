import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/features/home/home_page.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_page.dart';
import 'package:samba_public_app/features/parades/parades_tab.dart';
import 'package:samba_public_app/features/schools/schools_tab.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final primaryScrolls = List.generate(
      TabDestination.values.length,
      (_) => ScrollController(),
    );
    final router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/instruments',
      redirect: (context, state) {
        if (TabDestination.values
            .any((tab) => tab.path == state.uri.toString())) {
          final currentIndex = ref.read(selectedHomeTabIndexProvider);
          final newIndex = TabDestination.values.indexWhere(
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
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              HomePage(navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: InstrumentsTabPage.route.path,
                  builder: (context, state) => InstrumentsTabPage.route.builder(
                    context,
                    state,
                    primaryScrolls[0], // InstrumentsTab
                  ),
                  routes: InstrumentsTabPage.route.routes.isNotEmpty
                      ? InstrumentsTabPage.route.routes
                      : [],
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
