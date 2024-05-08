import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common_widgets/cupertino_sheet_route.dart';
import '../core/providers/initialization.dart';
import '../core/providers/prefs.dart';
import '../features/home/home_page.dart';
import '../features/home/home_page_controller.dart';
import '../features/instruments/details/gallery_page/instruments_gallery_page.dart';
import '../features/instruments/details/instrument_details_page.dart';
import '../features/instruments/instruments_tab_page.dart';
import '../features/parades/parades_tab_page.dart';
import '../features/schools/details/school_details_page.dart';
import '../features/schools/schools_tab_page.dart';
import '../initialization.dart';

part 'app_router.g.dart';

/// Required by StatefulShellRoute in GoRouter
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// If we want to show a page/dialog that cover the bottombar
final _tabInstruments = GlobalKey<NavigatorState>(debugLabel: 'tabInstruments');

const initialLocationPrefKey = 'initialLocation';

@riverpod
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    final controllers = {
      for (final tab in HomeTab.values) tab.name: ScrollController(),
    };
    final listenable = ValueNotifier<String>(HomeTab.instruments.path);
    ref.listen(initialLocationProvider, (_, location) {
      listenable.value = location.value ?? listenable.value;
    });
    ref.watch(initializationProvider);

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      restorationScopeId: 'app',
      refreshListenable: listenable,
      initialLocation: Initialization.path,
      errorPageBuilder: (_, __) => const NoTransitionPage(
        child: Scaffold(body: Text('404 - Not Found')),
      ),
      redirect: (_, state) => _redirect(state, controllers),
      routes: [
        GoRoute(
          path: Initialization.path,
          pageBuilder: (_, __) => const NoTransitionPage(
            child: Initialization(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          pageBuilder: (_, __, shell) =>
              NoTransitionPage(child: HomePage(shell)),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _tabInstruments,
              routes: [
                GoRoute(
                  path: InstrumentsTabPage.path,
                  builder: (_, __) => PrimaryScrollController(
                    controller: controllers[InstrumentsTabPage.tab.name]!,
                    child: const InstrumentsTabPage(),
                  ),
                  routes: [
                    GoRoute(
                      path: InstrumentDetailsPage.path,
                      onExit: (_, __) {
                        Future.microtask(
                          () => ref
                              .read(homePageControllerProvider.notifier)
                              .set(InstrumentsTabPage.tab, top: true),
                        );

                        return Future.value(true);
                      },
                      builder: (_, state) => InstrumentDetailsPage(
                        id: int.parse(state.pathParameters['id']!),
                      ),
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: InstrumentsGalleryPage.path,
                          pageBuilder: (_, state) {
                            final extra = state.extra as Map<String, String>?;
                            if (extra == null) throw GoError('Extra is null');
                            final initialIndex = int.parse(extra['index']!);
                            final instrumentId = int.parse(extra['id']!);

                            return CupertinoPage(
                              fullscreenDialog: true,
                              child: InstrumentsGalleryPage(
                                initialIndex: initialIndex,
                                instrumentId: instrumentId,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ParadesTabPage.path,
                  builder: (_, __) => PrimaryScrollController(
                    controller: controllers[ParadesTabPage.tab.name]!,
                    child: const ParadesTabPage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: SchoolsTabPage.path,
                  builder: (_, __) {
                    return PrimaryScrollController(
                      controller: controllers[SchoolsTabPage.tab.name]!,
                      child: const SchoolsTabPage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: SchoolDetailsPage.path,
                      pageBuilder: (_, state) {
                        return AppCupertinoSheetPage(
                          child: SchoolDetailsPage(
                            id: int.parse(state.pathParameters['id']!),
                          ),
                        );
                      },
                      onExit: (_, __) {
                        Future.microtask(
                          () => ref
                              .read(homePageControllerProvider.notifier)
                              .set(SchoolsTabPage.tab, top: true),
                        );

                        return Future.value(true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _scrollTabToTheTop(ScrollController controller) {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  String? _redirect(
    GoRouterState state,
    Map<String, ScrollController> controllers,
  ) {
    final init = ref.watch(initializationProvider);
    if (init.isLoading) {
      return Initialization.path;
    }
    if (init.hasError) {
      return Initialization.path;
    }

    /// Logic to handle the scroll to the top when the root tab is the same
    final splittedPath =
        state.fullPath?.split('/').where((v) => v.isNotEmpty).toList();
    final topPath = '/${splittedPath?.firstOrNull ?? ''}';
    if (splittedPath != null && HomeTab.values.any((v) => v.path == topPath)) {
      final (homeTab, isTopRoute) = ref.read(homePageControllerProvider);
      final isPathTop = splittedPath.length == 1;
      if (homeTab.path != topPath || isTopRoute != isPathTop) {
        final nextTab = HomeTab.values.firstWhere((v) => v.path == topPath);
        Future.microtask(
          () => ref
              .read(homePageControllerProvider.notifier)
              .set(nextTab, top: isPathTop),
        );
      }
      if (homeTab.path == topPath && isTopRoute && isPathTop) {
        final nextTab = HomeTab.values.firstWhere((v) => v.path == topPath);
        Future.microtask(
          () => _scrollTabToTheTop(controllers[nextTab.name]!),
        );
      }
    }

    if (state.fullPath == Initialization.path) {
      final initialPath = ref.read(initialLocationProvider).value;
      if (initialPath != null) {
        return HomeTab.values.firstWhere((tab) => tab.path == initialPath).path;
      }

      return HomeTab.instruments.path;
    }

    return null;
  }
}

@riverpod
FutureOr<String?> initialLocation(InitialLocationRef ref) async {
  final prefs = await ref.watch(prefsProvider.future);

  return prefs.getString(initialLocationPrefKey);
}
