import 'package:flutter/material.dart';

import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../utils/immutable_list.dart';
import '../../../utils/screen_size.dart';
import '../home_page_controller.dart';
import 'adaptive_navigation_rail_footer.dart';

class AdaptiveNavigationRail extends StatelessWidget {
  const AdaptiveNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final ImmutableList<HomeTab> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const largeRailWidth = 256.0;
  static const smallRailWidth = 80.0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final screenSize = context.screenSize;
    final footerHeight = height <= ScreenSize.smallHeight
        ? AdaptiveNavigationRailFooter.heightCollapsed
        : AdaptiveNavigationRailFooter.heightFull;
    return ColoredBox(
      color: context.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: height - footerHeight,
            child: NavigationRail(
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.library_music,
                  color: context.colorScheme.primary,
                  size: (height * 0.1).clamp(24, 80),
                ),
              ),
              backgroundColor: context.colorScheme.surface,
              onDestinationSelected: onDestinationSelected,
              extended: screenSize.isLarge,
              selectedIndex: selectedIndex,
              indicatorShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              destinations: [
                for (final destination in destinations)
                  NavigationRailDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: Text(
                      destination.label(context),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
              ],
            ),
          ),
          ColoredBox(
            color: context.colorScheme.surface,
            child: SizedBox(
              height: footerHeight,
              width: screenSize.isLarge ? largeRailWidth : smallRailWidth,
              child: const AdaptiveNavigationRailFooter(),
            ),
          ),
        ],
      ),
    );
  }
}
