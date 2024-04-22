import 'package:flutter/material.dart';

extension ContextSnackBar on BuildContext {
  void showSnackBarText({
    required Widget content,
    Key? key,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        behavior: SnackBarBehavior.floating,
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
}
