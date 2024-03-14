import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AdaptiveNavigationBar(
        tabDestinations: TabDestination.values,
        onDestinationSelected: (index) {
          ///GoRouter redirect update the provider
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        selectedIndex: navigationShell.currentIndex,
      ),
    );
  }
}

enum TabDestination {
  instruments,
  parades,
  schools;

  String get label => switch (this) {
        TabDestination.instruments => 'Instruments',
        TabDestination.parades => 'Parades',
        TabDestination.schools => 'Schools'
      };

  IconData get icon => switch (this) {
        TabDestination.instruments => Icons.music_note,
        TabDestination.parades => Icons.flag,
        TabDestination.schools => Icons.school
      };

  IconData get selectedIcon => switch (this) {
        TabDestination.instruments => Icons.music_note_outlined,
        TabDestination.parades => Icons.flag_outlined,
        TabDestination.schools => Icons.school_outlined
      };
}
