import 'package:flutter/material.dart';

class InstrumentDetailsSummary extends StatelessWidget {
  const InstrumentDetailsSummary({
    required this.details,
    super.key,
  });

  final String details;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),

      /// TODO: Add FittedBox to make the width small
      child: Text(
        details,
      ),
    );
  }
}
