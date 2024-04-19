import 'package:flutter/material.dart';

import 'theme_of_context_extension.dart';

extension ContextSnackBar on BuildContext {
  void showSnackBar({
    required Widget content,
    Key? key,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        behavior: behavior ?? SnackBarBehavior.floating,
        content: content,
        key: key,
        backgroundColor: backgroundColor,
        elevation: elevation,
        padding: padding,
        width: width,
        shape: shape,
      ),
    );
  }

  void showSnackBarText(
    String text, {
    Key? key,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
  }) =>
      showSnackBar(
        content: Text(
          text,
          style: textTheme.titleSmall!.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        key: key,
        backgroundColor: backgroundColor,
        elevation: elevation,
        margin: margin,
        padding: padding,
        width: width,
        shape: shape,
        hitTestBehavior: hitTestBehavior,
        behavior: behavior,
      );
}
