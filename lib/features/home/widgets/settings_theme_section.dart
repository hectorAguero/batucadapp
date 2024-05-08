import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/app_cupertino_button.dart';
import '../../../constants.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../theme/theme_mode_controller.dart';
import '../../../utils/app_loggers.dart';

class SettingsThemeSection extends ConsumerWidget {
  const SettingsThemeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final trueBlack = ref.watch(appThemeTrueBlackProvider);

    return CupertinoListSection.insetGrouped(
      header: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          context.loc.theme.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey2.resolveFrom(context),
          ),
        ),
      ),
      children: [
        Container(
          color: context.colorScheme.surface,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SettingThemeMode(
                onPressed: () => ref
                    .read(themeModeControllerProvider.notifier)
                    .setThemeMode(ThemeMode.light),
                isSelected: themeMode.isLight,
                title: context.loc.light,
                icon: Icons.wb_sunny,
              ),
              SettingThemeMode(
                onPressed: () => ref
                    .read(themeModeControllerProvider.notifier)
                    .setThemeMode(ThemeMode.dark),
                isSelected: themeMode.isDark,
                title: context.loc.dark,
                icon: Icons.nightlight_round,
              ),
              SettingThemeMode(
                onPressed: () => ref
                    .read(themeModeControllerProvider.notifier)
                    .setThemeMode(ThemeMode.system),
                isSelected: themeMode.isSystem,
                title: context.loc.system,
                icon: Icons.brightness_auto,
              ),
            ],
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final colors = ref.watch(appSelectedColorsProvider);
            final isDefault = colors.name == AppColors.defaultColors().name;

            return CupertinoListTile(
              backgroundColor: context.colorScheme.surface,
              backgroundColorActivated: Colors.transparent,
              title: Text(context.loc.theme),
              trailing: AppCupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: isDefault
                    ? null
                    : () => ref
                        .read(appSelectedColorsProvider.notifier)
                        .setThemeColors(AppColors.defaultColors()),
                child: Text(isDefault ? '' : context.loc.resetTheme),
              ),
              subtitle: Text(
                colors.name == Constants.defaultColorName
                    ? context.loc.defaultTheme
                    : ref.watch(appSelectedColorsProvider).name,
                style: context.cupertinoTheme.textTheme.textStyle.copyWith(
                  color: CupertinoColors.systemGrey,
                ),
              ),
            );
          },
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

class SettingThemeMode extends StatelessWidget {
  const SettingThemeMode({
    required this.onPressed,
    required this.isSelected,
    required this.title,
    required this.icon,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isSelected;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCupertinoButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Container(
            width: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Icon(icon),
                  const SizedBox(height: 8),
                  Text(title),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: Checkbox.adaptive(
              shape: const CircleBorder(),
              value: isSelected,
              onChanged: (_) {
                logViews.finest('Checkbox.adaptive is disabled');
              },
            ),
          ),
        ],
      ),
    );
  }
}
