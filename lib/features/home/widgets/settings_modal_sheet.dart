import 'package:flutter/material.dart';
import 'package:samba_public_app/features/home/widgets/theme_selector.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void showSettingModalSheet(BuildContext context) {
  WoltModalSheet.show<void>(
    context: context,
    showDragHandle: false,
    pageListBuilder: (context) {
      return [
        WoltModalSheetPage(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          hasTopBarLayer: false,
          child: const SafeArea(
            minimum: EdgeInsets.only(top: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Column(
                children: [
                  ThemeSelectorTile(),
                ],
              ),
            ),
          ),
        ),
      ];
    },
  );
}
