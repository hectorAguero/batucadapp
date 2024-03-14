import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';

class AdaptiveNavigationRail extends StatelessWidget {
  const AdaptiveNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    super.key,
  });

  final List<TabDestination> destinations;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return NavigationRail(
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.library_music,
          color: context.colorScheme.primary,
          size: 80,
        ),
      ),
      extended: size.isLargeScreen || size.isExtraLargeScreen,
      selectedIndex: selectedIndex,
      indicatorShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      indicatorColor: context.colorScheme.secondary,
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
    );
  }
}
