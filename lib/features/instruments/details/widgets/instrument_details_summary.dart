import 'package:flutter/material.dart';
import '../../../../extensions/media_query_context_extension.dart';

class InstrumentDetailsSummary extends StatelessWidget {
  const InstrumentDetailsSummary({
    required this.details,
    super.key,
  });

  final String details;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding =
            (constraints.maxWidth - mediumScreen).clamp(16.0, mediumScreen);
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: padding),
          physics: const NeverScrollableScrollPhysics(),
          child: Text(
            details,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        );
      },
    );
  }
}
