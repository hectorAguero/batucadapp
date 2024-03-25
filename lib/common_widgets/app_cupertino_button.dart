import 'package:flutter/cupertino.dart';

///extended CupertinoButton to pass null values in the minimumSize and padding

class AppCupertinoButton extends StatelessWidget {
  const AppCupertinoButton({
    required this.child,
    required this.onPressed,
    this.color,
    this.padding,
    this.minSize,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? minSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.zero,
      minSize: minSize ?? 0,
      borderRadius: BorderRadius.circular(32),
      color: color,
      child: child,
    );
  }
}
