// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../core/extensions/js_bottom_padding_extension.dart';

/// Widget that calls the calls to JS to get the insets of web
/// https://github.com/flutter/flutter/issues/84833#issuecomment-1679737846
class AppWebPadding extends StatelessWidget {
  const AppWebPadding({
    required this.child,
    this.bottom = true,
    this.top = true,
    this.left = true,
    this.right = true,
    this.color,
    super.key,
  });

  const AppWebPadding.only({
    required this.child,
    this.bottom = false,
    this.top = false,
    this.left = false,
    this.right = false,
    this.color,
    super.key,
  }) : assert(
          bottom || top || left || right,
          'At least one of the padding sides must be true',
        );

  final Widget child;
  final bool bottom;
  final bool top;
  final bool left;
  final bool right;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        color: color,
        padding: EdgeInsets.only(
          bottom: bottom ? bottomInset() : 0,
          top: top ? topInset() : 0,
          left: left ? leftInset() : 0,
          right: right ? rightInset() : 0,
        ),
        child: child,
      );
    }

    return child;
  }
}

class WebPaddingSliver extends StatelessWidget {
  const WebPaddingSliver({
    required this.sliver,
    required this.bottom,
    required this.top,
    required this.left,
    required this.right,
    this.color,
    super.key,
  });
  final Widget sliver;
  final Color? color;
  final bool bottom;
  final bool top;
  final bool left;
  final bool right;

  const WebPaddingSliver.only({
    required this.sliver,
    this.bottom = false,
    this.top = false,
    this.left = false,
    this.right = false,
    this.color,
    super.key,
  }) : assert(
          bottom || top || left || right,
          'At least one of the padding sides must be true',
        );

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      DecoratedSliver(
        decoration: BoxDecoration(color: color),
        sliver: SliverPadding(
          padding: EdgeInsets.only(
            bottom: bottom ? bottomInset() : 0,
            top: top ? topInset() : 0,
            left: left ? leftInset() : 0,
            right: right ? rightInset() : 0,
          ),
          sliver: sliver,
        ),
      );
    }

    return sliver;
  }
}
