import 'package:dart_mappable/dart_mappable.dart';
import 'package:dio/dio.dart';
import 'package:dio_image_provider/dio_image_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'core/get_native_adapter.dart'
    if (dart.library.js_interop) 'package:samba_public_app/core/get_native_adapter_web.dart';
import 'core/shared_preferences_provider.dart';
import 'extensions/app_localization_extension.dart';
import 'extensions/media_query_context_extension.dart';
import 'features/home/widgets/adaptive_navigation_rail.dart';
import 'theme/theme_provider.dart';
import 'utils/unmodifiable_list_mapper.dart';

part 'initialization_page.g.dart';

@Riverpod(keepAlive: true)
Future<void> initialization(InitializationRef ref) async {
  MapperContainer.globals.use(UnmodifiableListViewMapper());
  final imageDio = Dio()..httpClientAdapter = getNativeAdapter();
  DioImage.defaultDio = imageDio..options.validateStatus = (status) => true;

  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });

  await ref.watch(sharedPreferencesProvider.future);
}

/// Widget class to manage asynchronous app initialization
class InitializationPage extends ConsumerWidget {
  const InitializationPage({required this.onLoaded, super.key});
  final WidgetBuilder onLoaded;

  static const routePath = '/startup';

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
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    return SelectionArea(
      child: Scaffold(
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
    return SelectionArea(
      child: Scaffold(
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
      ),
    );
  }
}
