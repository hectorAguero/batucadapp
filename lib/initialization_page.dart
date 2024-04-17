import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'core/shared_preferences_provider.dart';
import 'extensions/app_localization_extension.dart';
import 'features/home/widgets/adaptive_navigation_rail.dart';
import 'theme/theme_provider.dart';
import 'utils/immutable_list.dart';
import 'utils/main_logger.dart';
import 'utils/screen_size.dart';

part 'initialization_page.g.dart';

@Riverpod(keepAlive: true)
Future<void> initialization(InitializationRef ref) async {
  registerErrorHandlers();
  initializeFICMappers();
  if (kDebugMode) initLoggers(Level.FINE, {});
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });
  await ref.watch(sharedPreferencesProvider.future);
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

/// Widget class to manage asynchronous app initialization
class InitializationPage extends ConsumerWidget {
  const InitializationPage({required this.onLoaded, super.key});
  final WidgetBuilder onLoaded;

  static const path = '/startup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initProvider = ref.watch(initializationProvider);
    ref.watch(appThemeModeProvider);

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
    final padding = MediaQuery.paddingOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:
            kMinInteractiveDimensionCupertino + padding.top.clamp(52, 100),
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
