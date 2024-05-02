import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../core/extensions/js_bottom_padding_extension_web.dart';
import '../core/extensions/theme_of_context_extension.dart';
import '../utils/screen_size.dart';

class AppCupertinoSliverNavigationBar extends StatelessWidget {
  const AppCupertinoSliverNavigationBar({
    required this.largeTitle,
    this.leading,
    this.stretch,
    this.trailing,
    this.transitionBetweenRoutes = true,
    super.key,
  });

  final String largeTitle;
  final Widget? leading;
  final Widget? trailing;
  final bool? stretch;
  final bool transitionBetweenRoutes;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    return CupertinoSliverNavigationBar(
      largeTitle: Text(
        largeTitle,
        maxLines: 1,
      ),
      brightness: Theme.of(context).brightness,
      stretch: stretch ?? false,
      leading: leading,
      transitionBetweenRoutes: transitionBetweenRoutes,
      backgroundColor: Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: context.customInverseTextColor.withOpacity(0.1),
        ),
      ),
      padding: kIsWeb
          ? EdgeInsetsDirectional.only(
              end: rightInset() + 16,
              start: 16,
            )
          : const EdgeInsetsDirectional.symmetric(horizontal: 16),
      trailing: screenSize.isSmall && trailing != null ? trailing : null,
    );
  }
}
