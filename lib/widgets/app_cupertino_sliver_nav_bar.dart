import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/is_ios_or_macos_platform_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/home/widgets/settings_modal_sheet.dart';

class AppCupertinoSliverNavBar extends StatelessWidget {
  const AppCupertinoSliverNavBar({required this.largeTitle, super.key});

  final String largeTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(largeTitle),
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
                color: context.colorScheme.onSurface,
              ),
            )
          : null,
    );
  }
}
