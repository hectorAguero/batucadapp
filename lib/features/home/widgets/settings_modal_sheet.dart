import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/theme_selector.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void showSettingModalSheet(BuildContext context) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (context) {
      return [
        WoltModalSheetPage(
          topBarTitle: const SettingsTitle(),
          hasTopBarLayer: true,
          isTopBarLayerAlwaysVisible: true,
          child: const Column(
            children: [
              ThemeSelectorTile(),
            ],
          ),
        ),
      ];
    },
  );
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Settings',
      style: context.textTheme.titleLarge,
    );
  }
}
