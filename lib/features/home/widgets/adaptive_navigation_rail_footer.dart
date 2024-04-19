import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../localization/language.dart';
import '../../../localization/language_app_provider.dart';
import '../../../utils/screen_size.dart';
import 'settings_modal_sheet.dart';

class AdaptiveNavigationRailFooter extends ConsumerWidget {
  const AdaptiveNavigationRailFooter({super.key});

  static const heightFull = 162.0;
  static const heightCollapsed = 54.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final screenSize = context.screenSize;
    final themeMode = ref.watch(appThemeModeProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);
    if (MediaQuery.sizeOf(context).height < ScreenSize.smallHeight) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => showSettingModalSheet(
              context,
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
            child: CupertinoListTile.notched(
              title: screenSize.isLarge
                  ? Text(
                      context.loc.settingsTitle,
                      style: context.textTheme.titleMedium,
                    )
                  : const Icon(CupertinoIcons.settings),
              leading: screenSize.isLarge ? Icon(themeMode.icon) : null,
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PullDownButton(
          scrollController: ScrollController(),
          itemBuilder: (context) => [
            for (final language in Language.values)
              PullDownMenuItem.selectable(
                icon: language.languageCode == locale.languageCode
                    ? CupertinoIcons.device_phone_portrait
                    : null,
                title: language.name(context),
                subtitle: language.nativeName,
                selected: language == ref.watch(languageAppProvider).value,
                onTap: () {
                  ref.read(languageAppProvider.notifier).setLanguage(
                        language,
                        isSameAsPlatform:
                            language.languageCode == locale.languageCode,
                      );
                },
              ),
          ],
          buttonBuilder: (context, showMenu) => CupertinoListTile.notched(
            onTap: showMenu,
            leading: screenSize.isLarge
                ? Icon(
                    CupertinoIcons.flag,
                    color: context.colorScheme.onSurface,
                  )
                : null,
            title: !screenSize.isLarge
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      CupertinoIcons.flag,
                      color: context.colorScheme.onSurface,
                    ),
                  )
                : Text(
                    context.loc.language,
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
              child: screenSize.isMedium
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
            leading: screenSize.isLarge
                ? Icon(
                    CupertinoIcons.moon_stars,
                    color: themeMode.isLight
                        ? context.colorScheme.onSurface.withOpacity(0.5)
                        : context.colorScheme.onSurface,
                  )
                : null,
            title: screenSize.isMedium
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
                    context.loc.themeTrueBlack,
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
            title: screenSize.isLarge
                ? Text(
                    themeMode.label(context),
                    style: context.textTheme.titleMedium,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(themeMode.icon),
                  ),
            leading: screenSize.isLarge ? Icon(themeMode.icon) : null,
          ),
        ),
      ],
    );
  }
}
