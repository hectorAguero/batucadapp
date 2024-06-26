import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../localization/language.dart';
import '../../../localization/language_app_controller.dart';
import 'settings_theme_section.dart';

void showSettingModalSheet(
  BuildContext context, {
  bool showAsDialog = true,
}) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    useRootNavigator: true,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (_) => SettingsModalSheet(showAsDialog: showAsDialog),
  );
}

class SettingsModalSheet extends StatelessWidget {
  final bool showAsDialog;
  const SettingsModalSheet({
    super.key,
    this.showAsDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      controller: PrimaryScrollController.of(context),
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(context.loc.settingsTitle),
            titleTextStyle: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
            backgroundColor:
                CupertinoColors.systemGroupedBackground.resolveFrom(context),
            actions: [
              if (showAsDialog)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: AppCupertinoButton(
                    onPressed: () => Navigator.of(context).pop(),
                    padding: const EdgeInsets.all(4),
                    color: const CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.darkBackgroundGray,
                      darkColor: CupertinoColors.lightBackgroundGray,
                    ).resolveFrom(context),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const SettingsThemeSection(),
          const SettingsLanguageSection(),
        ],
      ),
    );
  }
}

class SettingsLanguageSection extends ConsumerWidget {
  const SettingsLanguageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoListSection.insetGrouped(
      additionalDividerMargin: 8,
      header: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          context.loc.language.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.systemGrey2.resolveFrom(context),
          ),
        ),
      ),
      children: [
        for (final language in Language.values)
          CupertinoListTile.notched(
            backgroundColor: context.colorScheme.surface,
            leading: Icon(
              ref.watch(languageAppControllerProvider).value == language
                  ? CupertinoIcons.check_mark_circled
                  : null,
              color: context.colorScheme.primary,
            ),
            onTap: () {
              ref
                  .read(languageAppControllerProvider.notifier)
                  .setLanguage(language);
            },
            title: Text(
              language.nativeName,
              maxLines: 2,
            ),
            trailing: language.isSameAsPlatform
                ? const Icon(
                    CupertinoIcons.device_phone_portrait,
                    size: 24,
                  )
                : null,
          ),
      ],
    );
  }
}
