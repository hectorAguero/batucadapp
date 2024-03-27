import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/is_ios_or_macos_platform_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/settings_modal_sheet.dart';

class AppCupertinoSliverNavBar extends StatelessWidget {
  const AppCupertinoSliverNavBar({
    required this.largeTitle,
    this.leading,
    this.stretch,
    super.key,
  });

  final String largeTitle;
  final Widget? leading;
  final bool? stretch;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(largeTitle),
      brightness: Theme.of(context).brightness,
      stretch: stretch ?? false,
      leading: leading,
      border: const Border(),
      backgroundColor: Colors.transparent,
      trailing: context.querySize.isSmallScreen
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.zero,
              alignment: Alignment.centerRight,
              onPressed: () => showSettingModalSheet(context),
              child: Icon(
                kIsCupertino ? CupertinoIcons.settings : Icons.settings,
              ),
            )
          : null,
    );
  }
}
