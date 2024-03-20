import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/home_page_controller.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

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

  static const footerSize = 97.0;

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
        Consumer(
          builder: (context, ref, child) {
            final themeMode = ref.watch(appThemeModeProvider);
            return SizedBox(
              height: footerSize,
              width: size.isLargeScreen || size.isExtraLargeScreen ? 256 : 96,
              child: ColoredBox(
                color: context.colorScheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (themeMode == ThemeMode.dark)
                      SwitchListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 72,
                          right: 24,
                        ),
                        value: ref.watch(appThemeTrueBlackProvider),
                        title: Text(
                          'True Black',
                          style: context.textTheme.titleMedium,
                        ),
                        onChanged: (value) => ref
                            .read(appThemeTrueBlackProvider.notifier)
                            .toggleTrueBlack(),
                      ),
                    const SizedBox(
                      child: Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 32),
                      title: size.isLargeScreen || size.isExtraLargeScreen
                          ? Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                switch (themeMode) {
                                  (ThemeMode.system) => 'System Theme',
                                  (ThemeMode.light) => 'Light Theme',
                                  (ThemeMode.dark) => 'Dark Theme',
                                },
                                style: context.textTheme.titleMedium,
                              ),
                            )
                          : Icon(
                              context.isLight
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                            ),
                      leading: size.isLargeScreen || size.isExtraLargeScreen
                          ? Icon(
                              context.isLight
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                            )
                          : null,
                      onTap:
                          ref.read(appThemeModeProvider.notifier).toggleTheme,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
