import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/settings_theme_section.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/localization/language_app_provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void showSettingModalSheet(
  BuildContext context, {
  EdgeInsets padding = const EdgeInsets.only(top: 24),
  bool showAsDialog = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    showDragHandle: false,
    pageListBuilder: (context) {
      return [
        SliverWoltModalSheetPage(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          hasTopBarLayer: false,
          mainContentSlivers: [
            Builder(
              builder: (context) {
                return SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Text(context.loc.settingsTitle),
                  titleTextStyle: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: CupertinoColors.systemGroupedBackground
                      .resolveFrom(context),
                  actions: [
                    if (showAsDialog)
                      CupertinoButton(
                        padding: const EdgeInsets.only(right: 16),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                  ],
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: showAsDialog ? EdgeInsets.zero : padding,
                child: const Column(
                  children: [
                    SettingsThemeSection(),
                    SettingsLanguageSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ];
    },
  );
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
              ref.watch(languageAppProvider).value == language
                  ? CupertinoIcons.check_mark_circled
                  : null,
              color: context.colorScheme.primary,
            ),
            onTap: () {
              ref.read(languageAppProvider.notifier).setLanguage(
                    language,
                    isSameAsPlatform: language.isSameAsPlatform,
                  );
            },
            title: Text(language.nativeName),
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
