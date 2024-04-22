import 'package:flutter/widgets.dart';

const _defaultLineHeight = 20.0;

extension TextLinesExtension on String {
  int calculateLines(BuildContext context, {double? width, TextStyle? style}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: style ?? DefaultTextStyle.of(context).style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width ?? MediaQuery.of(context).size.width);

    return textPainter.computeLineMetrics().length;
  }

  double calculateHeightByLines(
    BuildContext context, {
    double? width,
    TextStyle? style,
    double paddingHeight = 0,
  }) {
    final lines = calculateLines(context, width: width, style: style);

    return (lines * (style?.height ?? _defaultLineHeight)) + paddingHeight;
  }
}
