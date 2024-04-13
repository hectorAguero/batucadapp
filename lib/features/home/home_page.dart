import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/media_query_context_extension.dart';
import '../../utils/immutable_list.dart';
import 'home_page_controller.dart';
import 'widgets/adaptive_navigation_bar.dart';
import 'widgets/adaptive_navigation_rail.dart';

class HomePage extends ConsumerWidget {
  const HomePage(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: size.isSmallScreen
          ? navigationShell
          : Row(
              children: [
                AdaptiveNavigationRail(
                  destinations: ImmutableList(HomeTab.values),
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: onDestinationSelected,
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: navigationShell),
              ],
            ),
      bottomNavigationBar: !size.isSmallScreen
          ? null
          : AdaptiveNavigationBar(
              tabDestinations: ImmutableList(HomeTab.values),
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: onDestinationSelected,
            ),
    );
  }

  void onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
