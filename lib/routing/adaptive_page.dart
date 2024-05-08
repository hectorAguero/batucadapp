import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptivePage<T> extends Page<T> {
  final Widget child;
  final bool maintainState;
  final bool fullscreenDialog;

  const AdaptivePage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS
        ? CupertinoPageRoute(
            builder: (context) => child,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog,
          )
        : MaterialPageRoute(
            builder: (context) => child,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog,
          );
  }
}
