import 'package:flutter/material.dart';

import '../../../extensions/theme_of_context_extension.dart';

class ParadeItemYearLine extends StatelessWidget {
  const ParadeItemYearLine({
    required this.year,
    super.key,
  });

  final String? year;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: double.infinity,
      child: Column(
        children: [
          if (year != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  year ?? '',
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: LinearProgressIndicator(
                value: 1,
                minHeight: 8,
                borderRadius: year != null
                    ? const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      )
                    : BorderRadius.zero,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
