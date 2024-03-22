import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/app_providers.dart';
import 'package:samba_public_app/features/home/home_page.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_page.dart';
import 'package:samba_public_app/features/parades/parades_tab.dart';
import 'package:samba_public_app/features/schools/schools_tab_page.dart';
import 'package:samba_public_app/router/app_startup_widget.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });
  await ref.watch(sharedPreferencesProvider.future);
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final appStartupState = ref.watch(appStartupProvider);

  final primaryScrolls = List.generate(
    TabDestination.values.length,
    (_) => ScrollController(),
  );
  final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/instruments',
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: Scaffold(body: Text('404 - Not Found')),
    ),
    redirect: (context, state) {
      // * If the app is still initializing, show the /startup route
      if (appStartupState.isLoading || appStartupState.hasError) {
        return AppStartupWidget.routePath;
      }
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
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            // * This is just a placeholder
            // * The loaded route will be managed by GoRouter on state change
            onLoaded: (_) => const SizedBox.shrink(),
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
