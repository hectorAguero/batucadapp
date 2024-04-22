import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/extensions/app_localization_extension.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_controller.dart';
import 'l10n/app_localizations.dart';
import 'localization/language.dart';
import 'localization/language_app_controller.dart';
import 'routing/app_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MainApp()));
}

// ignore: prefer_match_file_name
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  void _initAndroid() {
    if (TargetPlatform.android != defaultTargetPlatform) return;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initAndroid();
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final isTrueBlack = ref.watch(appThemeTrueBlackProvider);
    final language = ref.watch(languageAppControllerProvider).valueOrNull;

    return MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (context) => context.loc.appTitle,
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme(trueBlack: isTrueBlack),
      themeMode: themeMode,
      themeAnimationStyle: AnimationStyle.noAnimation,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        maxScaleFactor: 2,
        child: child ?? const SizedBox.shrink(),
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language?.locale,
    );
  }
}
