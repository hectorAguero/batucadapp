import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../localization/language.dart';
import '../../../localization/language_app_controller.dart';
import '../../../theme/theme_mode_controller.dart';
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
    final themeMode = ref.watch(themeModeControllerProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);

    if (context.isSmallHeight) {
      return AdaptiveRailSmallHeight(isLarge: false, themeMode: themeMode);
    }

    return Column(
      children: [
        RailPullDown(
          locale: locale,
          themeMode: themeMode,
          isLarge: screenSize.isLarge,
        ),
        InkWell(
          onTap: themeMode.isLight
              ? null
              : ref.read(appThemeTrueBlackProvider.notifier).toggleTrueBlack,
          child: CupertinoListTile.notched(
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
            leading: Icon(
              CupertinoIcons.moon_stars,
              color: themeMode.isLight
                  ? context.colorScheme.onSurface.withOpacity(0.5)
                  : context.colorScheme.onSurface,
            ),
            title: Text(
              context.loc.themeTrueBlack,
              style: themeMode.isLight
                  ? context.titleMedium.copyWith(color: Colors.grey)
                  : context.textTheme.titleMedium,
            ),
          ),
        ),
        InkWell(
          onTap: ref.read(themeModeControllerProvider.notifier).toggleTheme,
          child: CupertinoListTile.notched(
            title: Text(
              themeMode.label(context),
              style: context.textTheme.titleMedium,
            ),
            leading: Icon(themeMode.icon),
          ),
        ),
      ],
    );
  }
}

class RailPullDown extends ConsumerWidget {
  const RailPullDown({
    required this.locale,
    required this.themeMode,
    required this.isLarge,
    super.key,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final bool isLarge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PullDownButton(
      scrollController: ScrollController(),
      itemBuilder: (context) => [
        for (final language in Language.values)
          PullDownMenuItem.selectable(
            icon: language.languageCode == locale.languageCode
                ? CupertinoIcons.device_phone_portrait
                : null,
            title: language.name(context),
            subtitle: language.nativeName,
            selected:
                language == ref.watch(languageAppControllerProvider).value,
            onTap: () {
              ref
                  .read(languageAppControllerProvider.notifier)
                  .setLanguage(language);
            },
          ),
      ],
      buttonBuilder: (context, showMenu) => CupertinoListTile.notched(
        onTap: showMenu,
        leading: isLarge
            ? Icon(
                CupertinoIcons.flag,
                color: context.colorScheme.onSurface,
              )
            : null,
        title: !isLarge
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
                    ? context.titleMedium.copyWith(color: Colors.grey)
                    : context.textTheme.titleMedium,
              ),
      ),
    );
  }
}

class AdaptiveRailSmallHeight extends StatelessWidget {
  final bool isLarge;
  final ThemeMode themeMode;

  const AdaptiveRailSmallHeight({
    required this.isLarge,
    required this.themeMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => showSettingModalSheet(context),
          child: CupertinoListTile.notched(
            title: isLarge
                ? Text(
                    context.loc.settingsTitle,
                    style: context.textTheme.titleMedium,
                  )
                : const Icon(CupertinoIcons.settings),
            leading: isLarge ? Icon(themeMode.icon) : null,
          ),
        ),
      ],
    );
  }
}
