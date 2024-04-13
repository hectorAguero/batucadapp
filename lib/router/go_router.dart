import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../features/home/home_page.dart';
import '../features/home/home_page_controller.dart';
import '../features/instruments/details/instrument_details_page.dart';
import '../features/instruments/instruments_tab_page.dart';
import '../features/parades/parades_tab_page.dart';
import '../features/schools/details/school_details_page.dart';
import '../features/schools/schools_tab_page.dart';
import '../initialization_page.dart';

part 'go_router.g.dart';

/// Required by StatefulShellRoute in GoRouter
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final controllers = IMap(
    {for (final tab in HomeTab.values) tab.name: ScrollController()},
  );
  final initProvider = ref.watch(initializationProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomeTab.instruments.path,
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: Scaffold(body: Text('404 - Not Found')),
    ),
    redirect: (context, state) {
      if (initProvider.isLoading) {
        return InitializationPage.path;
      }
      if (initProvider.hasError) {
        return InitializationPage.path;
      }
      final path = state.fullPath?.split('/');
      final topPath = path?.sublist(0, 2).join('/');
      if (path != null && HomeTab.values.any((v) => v.path == topPath)) {
        final home = ref.read(currentTabProvider);
        final nextTab = HomeTab.values.firstWhere(
          (t) => t.path == topPath,
        );
        final top = path.length <= 2;
        if (home.tab.path != nextTab.path || home.topRoute != top) {
          Future.microtask(
            () => ref.read(currentTabProvider.notifier).set(nextTab, top: top),
          );
        }
        if (home.tab.path == nextTab.path && home.topRoute == top) {
          Future.microtask(
            () => _scrollTabToTheTop(controllers[nextTab.name]!),
          );
        }

        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: InitializationPage.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: InitializationPage(
            // * Just a placeholder, route will be managed by GoRouter
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (_, __, shell) => NoTransitionPage(child: HomePage(shell)),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
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
                    onExit: (context) {
                      Future.microtask(
                        () => ref
                            .read(currentTabProvider.notifier)
                            .set(InstrumentsTabPage.tab, top: true),
                      );
                      return Future.value(true);
                    },
                    builder: (_, state) => InstrumentDetailsPage(
                      id: int.parse(state.pathParameters['id']!),
                    ),
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
                builder: (_, __) => PrimaryScrollController(
                  controller: controllers[SchoolsTabPage.tab.name]!,
                  child: const SchoolsTabPage(),
                ),
                routes: [
                  GoRoute(
                    path: SchoolDetailsPage.path,
                    onExit: (context) {
                      Future.microtask(
                        () => ref
                            .read(currentTabProvider.notifier)
                            .set(SchoolsTabPage.tab, top: true),
                      );
                      return Future.value(true);
                    },
                    pageBuilder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      return SchoolDetailsPage.getWoltModal(id);
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
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }
}

class SheetPage extends Page<void> {
  const SheetPage({
    required this.pageIndexNotifier,
    required this.pageListBuilderNotifier,
  }) : super(key: const ValueKey('SheetPage'));

  final ValueNotifier<int> pageIndexNotifier;
  final ValueNotifier<WoltModalSheetPageListBuilder> pageListBuilderNotifier;

  static const String routeName = 'Modal Sheet';

  @override
  Route<void> createRoute(BuildContext context) {
    return WoltModalSheetRoute<void>(
      pageIndexNotifier: pageIndexNotifier,
      pageListBuilderNotifier: pageListBuilderNotifier,
      useSafeArea: false,
      onModalDismissedWithDrag: () {
        context.pop();
      },
      onModalDismissedWithBarrierTap: () {
        context.pop();
      },
      routeSettings: this,
    );
  }

  @override
  String get name => routeName;
}