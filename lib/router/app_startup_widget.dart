import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_rail.dart';
import 'package:samba_public_app/router/router.dart';

/// Widget class to manage asynchronous app initialization
class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({required this.onLoaded, super.key});
  final WidgetBuilder onLoaded;

  static const routePath = '/startup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      key: ValueKey(appStartupState.isLoading),
      child: appStartupState.when(
        data: (_) => onLoaded(context),
        loading: () => const AppStartupLoadingWidget(),
        error: (e, st) => AppStartupErrorWidget(
          message: e.toString(),
          onRetry: () {
            ref.invalidate(appStartupProvider);
          },
        ),
      ),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kMinInteractiveDimensionCupertino + 52,
      ),
      backgroundColor: Colors.transparent,
      body: size.isSmallScreen
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Row(
              children: [
                SizedBox(
                  width: size.isExtraLargeScreen || size.isLargeScreen
                      ? AdaptiveNavigationRail.largeRailWidth
                      : AdaptiveNavigationRail.smallRailWidth,
                ),
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
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
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
