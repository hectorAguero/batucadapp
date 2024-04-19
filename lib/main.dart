import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/extensions/app_localization_extension.dart';
import 'core/theme/theme_data.dart';
import 'core/theme/theme_provider.dart';
import 'l10n/app_localizations.dart';
import 'localization/language.dart';
import 'localization/language_app_provider.dart';
import 'routing/app_router.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MainApp()));
}

///This widget is the root of your application.
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
    final themeMode = ref.watch(appThemeModeProvider);
    final isTrueBlack = ref.watch(appThemeTrueBlackProvider);
    final language = ref.watch(languageAppProvider).valueOrNull;
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
        child: child!,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language?.locale,
    );
  }
}
