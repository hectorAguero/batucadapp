import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

class ThemeSelectorRail extends ConsumerWidget {
  const ThemeSelectorRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final themeMode = ref.watch(appThemeModeProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CupertinoListTile.notched(
          trailing: IgnorePointer(
            child: size.isMediumScreen
                ? null
                : Switch.adaptive(
                    value: trueBlack,
                    applyCupertinoTheme: true,
                    onChanged: themeMode.isLight
                        ? null
                        : (_) => ref
                            .read(appThemeTrueBlackProvider.notifier)
                            .toggleTrueBlack(),
                  ),
          ),
          leading: size.isLargeScreen || size.isExtraLargeScreen
              ? Icon(
                  CupertinoIcons.moon_stars,
                  color: themeMode.isLight
                      ? context.colorScheme.onSurface.withOpacity(0.5)
                      : context.colorScheme.onSurface,
                )
              : null,
          title: size.isMediumScreen
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    CupertinoIcons.moon_stars,
                    color: themeMode.isLight
                        ? context.colorScheme.onSurface.withOpacity(0.5)
                        : context.colorScheme.onSurface,
                  ),
                )
              : Text(
                  'True Black',
                  style: themeMode.isLight
                      ? context.textTheme.titleMedium!
                          .copyWith(color: Colors.grey)
                      : context.textTheme.titleMedium,
                ),
          onTap: themeMode.isLight
              ? null
              : () async => ref
                  .read(appThemeTrueBlackProvider.notifier)
                  .toggleTrueBlack(),
        ),
        const SizedBox(
          child: Divider(
            thickness: 1,
            height: 1,
          ),
        ),
        CupertinoListTile.notched(
          title: size.isLargeScreen || size.isExtraLargeScreen
              ? Text(
                  switch (themeMode) {
                    (ThemeMode.system) => 'System Theme',
                    (ThemeMode.light) => 'Light Theme',
                    (ThemeMode.dark) => 'Dark Theme',
                  },
                  style: context.textTheme.titleMedium,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(themeMode.icon),
                ),
          leading: size.isLargeScreen || size.isExtraLargeScreen
              ? Icon(themeMode.icon)
              : null,
          onTap: () async =>
              ref.read(appThemeModeProvider.notifier).toggleTheme(),
        ),
      ],
    );
  }
}

class ThemeSelectorTile extends ConsumerWidget {
  const ThemeSelectorTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);

    return Column(
      children: [
        CupertinoListTile.notched(
          backgroundColorActivated: Colors.transparent,
          trailing: CupertinoButton.filled(
            onPressed: null,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  themeMode.icon,
                  color: context.colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Text(
                  switch (themeMode) {
                    (ThemeMode.system) => 'System',
                    (ThemeMode.light) => 'Light',
                    (ThemeMode.dark) => 'Dark',
                  },
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          title: const Text('Switch Theme'),
          onTap: () async =>
              ref.read(appThemeModeProvider.notifier).toggleTheme(),
        ),
        CupertinoListTile.notched(
          trailing: IgnorePointer(
            child: Switch.adaptive(
              value: trueBlack,
              applyCupertinoTheme: true,
              onChanged: themeMode.isLight
                  ? null
                  : (_) => ref
                      .read(appThemeTrueBlackProvider.notifier)
                      .toggleTrueBlack(),
            ),
          ),
          title: Text(
            'True Black',
            style:
                themeMode.isLight ? const TextStyle(color: Colors.grey) : null,
          ),
          onTap: themeMode.isLight
              ? null
              : () async => ref
                  .read(appThemeTrueBlackProvider.notifier)
                  .toggleTrueBlack(),
        ),
      ],
    );
  }
}
