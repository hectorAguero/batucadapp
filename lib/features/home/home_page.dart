import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/app_web_padding.dart';
import '../../core/extensions/theme_of_context_extension.dart';
import '../../utils/immutable_list.dart';
import '../../utils/screen_size.dart';
import 'home_page_controller.dart';
import 'widgets/adaptive_navigation_bar.dart';
import 'widgets/adaptive_navigation_rail.dart';

class HomePage extends ConsumerWidget {
  const HomePage(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = context.screenSize;

    return Scaffold(
      body: screenSize.isSmall
          ? navigationShell
          : AppWebPadding.only(
              left: true,
              color: context.colorScheme.surface,
              child: Row(
                children: [
                  AdaptiveNavigationRail(
                    destinations: ImmutableList(HomeTab.values),
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: onDestinationSelected,
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: navigationShell,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: screenSize.isMedium || screenSize.isLarge
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: CupertinoDynamicColor.resolve(
                    CupertinoColors.opaqueSeparator,
                    context,
                  ),
                ),
                AdaptiveNavigationBar(
                  tabDestinations: ImmutableList(HomeTab.values),
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: onDestinationSelected,
                ),
              ],
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
