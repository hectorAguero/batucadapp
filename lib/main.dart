import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/router/router.dart';
import 'package:samba_public_app/theme/theme_data.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

/// MyApp is a StatelessWidget. This widget is the root of your application.
class MainApp extends ConsumerWidget {
  /// Creates a MaterialApp widget.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final isTrueBlack = ref.watch(appThemeTrueBlackProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Samba Public App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme(trueBlack: isTrueBlack),
      themeMode: ref.watch(appThemeModeProvider) ?? ThemeMode.system,
    );
  }
}
