import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../../theme/theme_provider.dart';

class SettingsThemeSection extends ConsumerWidget {
  const SettingsThemeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);

    return CupertinoListSection.insetGrouped(
      header: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          context.loc.theme.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey2.resolveFrom(context),
          ),
        ),
      ),
      children: [
        CupertinoListTile(
          backgroundColor: context.colorScheme.surface,
          title: CupertinoSegmentedControl<ThemeMode>(
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
                child: Text(context.loc.light),
              ),
              ThemeMode.dark: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(context.loc.dark),
              ),
              ThemeMode.system: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(context.loc.system),
              ),
            },
          ),
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
            context.loc.themeTrueBlack,
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
