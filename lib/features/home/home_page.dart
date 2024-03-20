import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_bar.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_rail.dart';

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
                  destinations: TabDestination.values,
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) {
                    ///GoRouter redirect update the provider
                    navigationShell.goBranch(
                      index,
                      initialLocation: index == navigationShell.currentIndex,
                    );
                  },
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: navigationShell),
              ],
            ),
      bottomNavigationBar: size.isSmallScreen
          ? AdaptiveNavigationBar(
              tabDestinations: TabDestination.values,
              onDestinationSelected: (index) {
                ///GoRouter redirect update the provider
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              selectedIndex: navigationShell.currentIndex,
            )
          : null,
    );
  }
}
