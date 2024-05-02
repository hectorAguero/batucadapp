import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/is_ios_or_macos_platform_extension.dart';
import 'settings_modal_sheet.dart';

class AppBarTrailingSettingsIcon extends StatelessWidget {
  const AppBarTrailingSettingsIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      alignment: Alignment.centerRight,
      onPressed: () => showSettingModalSheet(context),
      child: Icon(
        kIsCupertino ? CupertinoIcons.settings : Icons.settings,
      ),
    );
  }
}
