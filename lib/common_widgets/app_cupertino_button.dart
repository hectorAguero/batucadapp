import 'package:flex_color_scheme/flex_color_scheme.dart';
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
    this.minSize,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    this.type = CupertinoButtonType.plain,
  });

  const AppCupertinoButton.tinted({
    required this.child,
    required this.onPressed,
    required this.color,
    super.key,
    this.disabledColor,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.type = CupertinoButtonType.tinted,
    this.minSize,
  });

  final Widget child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? minSize;
  final Color? color;
  final Color? disabledColor;
  final BorderRadius borderRadius;
  final CupertinoButtonType type;

  @override
  Widget build(BuildContext context) {
    final typeSize = type == CupertinoButtonType.plain
        ? 0.0
        : kMinInteractiveDimensionCupertino;

    return Theme(
      data: Theme.of(context).copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: color ?? context.colorScheme.primary,
          primaryContrastingColor: color ?? context.colorScheme.primary,
          scaffoldBackgroundColor: color ?? context.colorScheme.primary,
          textTheme: const CupertinoTextThemeData(
            primaryColor: Colors.white,
            textStyle: TextStyle(),
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          return CupertinoButton(
            disabledColor:
                disabledColor ?? CupertinoColors.quaternarySystemFill,
            onPressed: onPressed,
            padding: padding,
            minSize: minSize ?? typeSize,
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

  static const tintedOpacity = 0.2;

  Color? calculateColor(
    Color? color,
    BuildContext context,
  ) {
    return switch (this) {
      CupertinoButtonType.plain => null,
      CupertinoButtonType.gray => CupertinoColors.systemFill,
      CupertinoButtonType.tinted => color?.withOpacity(tintedOpacity),
      CupertinoButtonType.filled => context.colorScheme.primary.darken()
    };
  }
}
