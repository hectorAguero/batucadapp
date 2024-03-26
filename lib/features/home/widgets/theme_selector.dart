import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/localization/language_app_provider.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

class ThemeSelectorRail extends ConsumerWidget {
  const ThemeSelectorRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final themeMode = ref.watch(appThemeModeProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);
    final platformLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PullDownButton(
          scrollController: ScrollController(),
          itemBuilder: (context) => [
            for (final language in Language.values)
              PullDownMenuItem.selectable(
                icon: language.languageCode == platformLanguage
                    ? CupertinoIcons.device_phone_portrait
                    : null,
                title: language.name,
                subtitle: language.nativeName,
                selected: language == ref.watch(languageAppProvider).value,
                onTap: () {
                  ref.read(languageAppProvider.notifier).setLanguage(
                        language,
                        isSameAsPlatform:
                            language.languageCode == platformLanguage,
                      );
                },
              ),
          ],
          buttonBuilder: (context, showMenu) => CupertinoListTile.notched(
            onTap: showMenu,
            leading: size.isLargeScreen || size.isExtraLargeScreen
                ? Icon(
                    CupertinoIcons.flag,
                    color: context.colorScheme.onSurface,
                  )
                : null,
            title: size.isMediumScreen
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      CupertinoIcons.flag,
                      color: context.colorScheme.onSurface,
                    ),
                  )
                : Text(
                    'Language'.hardcoded,
                    style: themeMode.isLight
                        ? context.textTheme.titleMedium!
                            .copyWith(color: Colors.grey)
                        : context.textTheme.titleMedium,
                  ),
          ),
        ),
        InkWell(
          onTap: themeMode.isLight
              ? null
              : () async => ref
                  .read(appThemeTrueBlackProvider.notifier)
                  .toggleTrueBlack(),
          child: CupertinoListTile.notched(
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
                    'True Black'.hardcoded,
                    style: themeMode.isLight
                        ? context.textTheme.titleMedium!
                            .copyWith(color: Colors.grey)
                        : context.textTheme.titleMedium,
                  ),
          ),
        ),
        InkWell(
          onTap: () async =>
              ref.read(appThemeModeProvider.notifier).toggleTheme(),
          child: CupertinoListTile.notched(
            title: size.isLargeScreen || size.isExtraLargeScreen
                ? Text(
                    themeMode.labelName,
                    style: context.textTheme.titleMedium,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(themeMode.icon),
                  ),
            leading: size.isLargeScreen || size.isExtraLargeScreen
                ? Icon(themeMode.icon)
                : null,
          ),
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

    return CupertinoListSection.insetGrouped(
      header: Text('Theme'.hardcoded),
      children: [
        CupertinoListTile(
          backgroundColor: context.colorScheme.surface,
          trailing: CupertinoSegmentedControl<ThemeMode>(
            padding: EdgeInsets.zero,
            // This represents a currently selected segmented control.
            groupValue: ref.watch(appThemeModeProvider),
            // Callback that sets the selected segmented control.
            onValueChanged: (ThemeMode value) {
              ref.read(appThemeModeProvider.notifier).setTheme(value);
            },
            children: <ThemeMode, Widget>{
              ThemeMode.light: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text('Light'.hardcoded),
              ),
              ThemeMode.dark: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text('Dark'.hardcoded),
              ),
              ThemeMode.system: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text('System'.hardcoded),
              ),
            },
          ),
          title: Text('Switch Theme'.hardcoded),
        ),
        CupertinoListTile(
          backgroundColor: context.colorScheme.surface,
          backgroundColorActivated: Colors.transparent,
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
            'True Black'.hardcoded,
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
