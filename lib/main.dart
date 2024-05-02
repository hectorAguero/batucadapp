import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/extensions/app_localization_extension.dart';
import 'l10n/app_localizations.dart';
import 'localization/language.dart';
import 'localization/language_app_controller.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_controller.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MainApp()));
}

// ignore: prefer_match_file_name
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  void _initAndroid() {
    if (TargetPlatform.android != defaultTargetPlatform) return;
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initAndroid();
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final isTrueBlack = ref.watch(appThemeTrueBlackProvider);
    final themeColors = ref.watch(appSelectedColorsProvider);
    final language = ref.watch(languageAppControllerProvider).valueOrNull;

    return MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (context) => context.loc.appTitle,
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(themeColors),
      darkTheme: AppTheme.darkTheme(themeColors, trueBlack: isTrueBlack),
      themeMode: themeMode,
      themeAnimationStyle: AnimationStyle.noAnimation,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (_, child) => MediaQuery.withClampedTextScaling(
        maxScaleFactor: 2,
        child: child ?? const SizedBox.shrink(),
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language?.locale,
    );
  }
}
