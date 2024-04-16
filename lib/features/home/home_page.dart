import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/app_web_padding.dart';
import '../../extensions/media_query_context_extension.dart';
import '../../extensions/theme_of_context_extension.dart';
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
      bottomNavigationBar: !size.isSmallScreen
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
