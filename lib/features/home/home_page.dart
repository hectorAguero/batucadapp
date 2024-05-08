import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common_widgets/app_web_padding.dart';
import '../../core/extensions/theme_of_context_extension.dart';
import '../../utils/immutable_list.dart';
import '../../utils/screen_size.dart';
import '../instruments/instruments_tab_controller.dart';
import '../parades/parades_tab_controller.dart';
import '../schools/schools_tab_controller.dart';
import 'home_page_controller.dart';
import 'widgets/adaptive_navigation_bar.dart';
import 'widgets/adaptive_navigation_rail.dart';

class HomePage extends ConsumerWidget {
  const HomePage(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = context.screenSize;
    final color = defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS
        ? Theme.of(context).bottomNavigationBarTheme.backgroundColor
        : Theme.of(context).colorScheme.primaryContainer;
    final orientation = MediaQuery.orientationOf(context);

    return _EagerInitialization(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          systemNavBarStyle: orientation == Orientation.landscape
              ? FlexSystemNavBarStyle.transparent
              : FlexSystemNavBarStyle.system,
          nullContextBrightness: Brightness.dark,
          systemNavigationBarColor:
              orientation == Orientation.landscape ? null : color,
        ),
        child: Scaffold(
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
          bottomNavigationBar: !screenSize.isSmall
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
        ),
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

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    ref.watch(instrumentsTabControllerProvider);
    ref.watch(paradesTabControllerProvider);
    ref.watch(schoolsTabControllerProvider);

    return child;
  }
}
