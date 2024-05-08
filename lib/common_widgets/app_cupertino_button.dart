import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/extensions/theme_of_context_extension.dart';

///extended CupertinoButton to pass null values in the minimumSize and padding

class AppCupertinoButton extends StatelessWidget {
  const AppCupertinoButton({
    required this.child,
    required this.onPressed,
    super.key,
    this.color,
    this.disabledColor,
    this.icon,
    this.padding = EdgeInsets.zero,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    this.type = CupertinoButtonType.plain,
  });

  const AppCupertinoButton.tinted({
    required this.child,
    required this.onPressed,
    this.color,
    super.key,
    this.disabledColor,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = EdgeInsets.zero,
    this.type = CupertinoButtonType.tinted,
    this.minSize = kMinInteractiveDimensionCupertino,
  });

  const AppCupertinoButton.filled({
    required this.child,
    required this.onPressed,
    this.color,
    super.key,
    this.disabledColor,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = EdgeInsets.zero,
    this.type = CupertinoButtonType.filled,
    this.minSize = kMinInteractiveDimensionCupertino,
  });

  final Widget child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double minSize;
  final Color? color;
  final Color? disabledColor;
  final BorderRadius borderRadius;
  final CupertinoButtonType type;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor:
              color ?? context.theme.cupertinoOverrideTheme?.primaryColor,
          primaryContrastingColor: type == CupertinoButtonType.tinted
              ? color ?? context.colorScheme.primary
              : null,
          scaffoldBackgroundColor: color ?? context.colorScheme.primary,
        ),
      ),
      child: Builder(
        builder: (context) {
          if (type == CupertinoButtonType.filled) {
            CupertinoButton.filled(
              disabledColor:
                  disabledColor ?? CupertinoColors.quaternarySystemFill,
              onPressed: onPressed,
              padding: padding,
              minSize: minSize,
              borderRadius: borderRadius,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: icon,
                    ),
                  child,
                ],
              ),
            );
          }

          return CupertinoButton(
            disabledColor:
                disabledColor ?? CupertinoColors.quaternarySystemFill,
            onPressed: onPressed,
            padding: padding,
            minSize: minSize,
            borderRadius: borderRadius,
            color: type.calculateColor(color, context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: icon,
                  ),
                child,
              ],
            ),
          );
        },
      ),
    );
  }
}

enum CupertinoButtonType {
  plain,
  gray,
  tinted,
  filled;

  static const tintedOpacity = 0.5;

  Color? calculateColor(
    Color? color,
    BuildContext context,
  ) {
    return switch (this) {
      CupertinoButtonType.plain => null,
      CupertinoButtonType.gray => CupertinoColors.systemFill,
      CupertinoButtonType.tinted => color?.withOpacity(tintedOpacity) ??
          context.theme.cupertinoOverrideTheme?.primaryColor
              ?.withOpacity(tintedOpacity),
      CupertinoButtonType.filled =>
        color ?? context.theme.cupertinoOverrideTheme?.primaryColor
    };
  }
}
