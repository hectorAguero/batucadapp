import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/features/home/widgets/theme_selector.dart';

class AdaptiveNavigationRail extends StatelessWidget {
  const AdaptiveNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<TabDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const footerSize = 115.0;
  static const largeRailWidth = 256.0;
  static const smallRailWidth = 96.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: size.height - footerSize,
          child: NavigationRail(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.library_music,
                color: context.colorScheme.primary,
                size: 80,
              ),
            ),
            backgroundColor: context.colorScheme.surface,
            onDestinationSelected: onDestinationSelected,
            extended: size.isLargeScreen || size.isExtraLargeScreen,
            selectedIndex: selectedIndex,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            destinations: [
              for (final destination in destinations)
                NavigationRailDestination(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(
                    destination.label,
                    style: context.textTheme.titleMedium,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: footerSize,
          width: size.isLargeScreen || size.isExtraLargeScreen
              ? largeRailWidth
              : smallRailWidth,
          child: ColoredBox(
            color: context.colorScheme.surface,
            child: const ThemeSelectorRail(),
          ),
        ),
      ],
    );
  }
}
