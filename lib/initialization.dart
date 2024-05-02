import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/extensions/app_localization_extension.dart';
import 'core/providers/initialization.dart';
import 'features/home/widgets/adaptive_navigation_rail.dart';
import 'theme/theme_mode_controller.dart';
import 'utils/screen_size.dart';

class Initialization extends ConsumerWidget {
  const Initialization({required this.onLoaded, super.key});
  final WidgetBuilder onLoaded;

  static const path = '/startup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeModeControllerProvider);
    final initProvider = ref.watch(initializationProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (initProvider) {
        AsyncData() => onLoaded(context),
        AsyncLoading() => const AppStartupLoadingWidget(),
        AsyncError(:final error) => AppStartupErrorWidget(
            message: error.toString(),
            onRetry: () {
              ref.invalidate(initializationProvider);
            },
          ),
      },
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: kMinInteractiveDimensionCupertino +
            MediaQuery.paddingOf(context).top.clamp(52, 100),
      ),
      bottomNavigationBar: screenSize.isSmall
          ? null
          : const SizedBox(height: kMinInteractiveDimensionCupertino),
      body: screenSize.isSmall
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Row(
              children: [
                SizedBox(
                  width: screenSize.isLarge
                      ? AdaptiveNavigationRail.largeRailWidth
                      : AdaptiveNavigationRail.smallRailWidth,
                ),
                const Expanded(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
              ],
            ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(context.loc.retry),
            ),
          ],
        ),
      ),
    );
  }
}
