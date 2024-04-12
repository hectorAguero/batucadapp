import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/home/home_page.dart';
import '../features/home/home_page_controller.dart';
import '../features/instruments/instruments_tab_page.dart';
import '../features/parades/parades_tab_page.dart';
import '../features/schools/schools_tab_page.dart';
import '../initialization_page.dart';
import '../utils/unmodifiable_list.dart';

part 'router.g.dart';

/// Required by StatefulShellRoute in GoRouter
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final primaryScrolls = UnmodifiableList(
    [for (final _ in TabDestination.values) ScrollController()],
  );
  final initProvider = ref.watch(initializationProvider);
  final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/instruments',
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: Scaffold(body: Text('404 - Not Found')),
    ),
    redirect: (context, state) {
      // * If the app is still initializing, show the /startup route
      if (initProvider.isLoading || initProvider.hasError) {
        return InitializationPage.routePath;
      }
      if (TabDestination.values
          .any((tab) => tab.path == state.uri.toString())) {
        final currentIndex = ref.read(selectedHomeTabIndexProvider);
        final newIndex = TabDestination.values.indexWhere(
          (tab) => tab.path == state.uri.toString(),
        );
        if (currentIndex != newIndex) {
          Future.microtask(() {
            ref.read(selectedHomeTabIndexProvider.notifier).select(newIndex);
          });
        } else {
          _checkScrollController(
            primaryScrolls[newIndex],
            state,
          );
        }
      }
      return state.path == 'startup' ? '/instruments' : null;
    },
    routes: [
      GoRoute(
        path: InitializationPage.routePath,
        pageBuilder: (context, state) => NoTransitionPage(
          child: InitializationPage(
            // * This is just a placeholder
            // * The loaded route will be managed by GoRouter on state change
            onLoaded: (_) => const CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            NoTransitionPage(child: HomePage(navigationShell)),
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
                path: ParadesTabPage.route.path,
                builder: (context, state) => ParadesTabPage.route.builder(
                  context,
                  state,
                  primaryScrolls[1], // ParadesTab
                ),
                routes: ParadesTabPage.route.routes,
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: SchoolsTabPage.route.path,
                builder: (context, state) => SchoolsTabPage.route.builder(
                  context,
                  state,
                  primaryScrolls[2],
                ),
                routes: SchoolsTabPage.route.routes,
              ),
            ],
          ),
        ],
      ),
    ],
  );

  return router;
}

void _checkScrollController(ScrollController controller, GoRouterState state) {
  if (controller.hasClients) {
    controller.animateTo(
      0,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }
}
