import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../extensions/is_ios_or_macos_platform_extension.dart';

import '../extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../extensions/js_bottom_padding_extension_web.dart';

import '../extensions/media_query_context_extension.dart';
import '../extensions/theme_of_context_extension.dart';
import '../features/home/widgets/settings_modal_sheet.dart';

class AppCupertinoSliverNavigationBar extends StatelessWidget {
  const AppCupertinoSliverNavigationBar({
    required this.largeTitle,
    this.leading,
    this.stretch,
    this.transitionBetweenRoutes = true,
    super.key,
  });

  final String largeTitle;
  final Widget? leading;
  final bool? stretch;
  final bool transitionBetweenRoutes;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: Colors.transparent,
      largeTitle: Text(
        largeTitle,
        maxLines: 1,
      ),
      brightness: Theme.of(context).brightness,
      stretch: stretch ?? false,
      leading: leading,
      transitionBetweenRoutes: transitionBetweenRoutes,
      border: Border(
        bottom: BorderSide(
          color: context.customColors.inverseTextColor!.withOpacity(0.1),
        ),
      ),
      padding: kIsWeb
          ? EdgeInsetsDirectional.only(
              end: rightInset() + 16,
              start: 16,
            )
          : const EdgeInsetsDirectional.symmetric(horizontal: 16),
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
