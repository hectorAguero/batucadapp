import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/router/router.dart';
import 'package:samba_public_app/theme/theme_data.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// MyApp is a StatelessWidget. This widget is the root of your application.
class MyApp extends ConsumerWidget {
  /// Creates a MaterialApp widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Samba Public App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(appThemeModeProvider),
    );
  }
}
