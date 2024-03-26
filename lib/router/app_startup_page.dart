import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/adaptive_navigation_rail.dart';
import 'package:samba_public_app/main_providers.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

part 'app_startup_page.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });
  await ref.watch(sharedPreferencesProvider.future);
}

/// Widget class to manage asynchronous app initialization
class AppStartupPage extends ConsumerWidget {
  const AppStartupPage({required this.onLoaded, super.key});
  final WidgetBuilder onLoaded;

  static const routePath = '/startup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    ref.watch(appThemeModeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      key: ValueKey(appStartupState.isLoading),
      child: switch (appStartupState) {
        AsyncData() => onLoaded(context),
        AsyncLoading() => const AppStartupLoadingWidget(),
        AsyncError(:final error) => AppStartupErrorWidget(
            message: error.toString(),
            onRetry: () {
              ref.invalidate(appStartupProvider);
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
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:
            kMinInteractiveDimensionCupertino + padding.top.clamp(52, 100),
      ),
      bottomNavigationBar: size.isSmallScreen
          ? null
          : const SizedBox(height: kMinInteractiveDimensionCupertino),
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
              child: Text('Retry'.hardcoded),
            ),
          ],
        ),
      ),
    );
  }
}
