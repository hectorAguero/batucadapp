import 'package:flutter/material.dart';

import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/intl_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../parade.dart';
import '../parade_extension.dart';

class ParadeItemSideBar extends StatelessWidget {
  const ParadeItemSideBar({
    required this.placing,
    required this.parade,
    super.key,
  });

  final int placing;
  final Parade parade;

  @override
  Widget build(BuildContext context) {
    final medalColor = parade.medalColor(context);
    return Container(
      width: 48,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
          stops: const [0.2, 1],
          colors: [
            medalColor,
            medalColor.withOpacity(0.5),
          ],
        ),
      ),
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1.1,
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${parade.getPerformanceIcon}\n',
                    style: const TextStyle(fontSize: 30),
                  ),
                  if (parade.points > 0)
                    TextSpan(
                      text: parade.points.toString(),
                      style: context.textTheme.labelMedium,
                    ),
                ],
              ),
              style: const TextStyle(fontSize: 24),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text.rich(
                  maxLines: 1,
                  TextSpan(
                    children: [
                      TextSpan(
                        style: context.textTheme.headlineSmall!.copyWith(
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          if (parade.placing > 0)
                            TextSpan(
                              text: '${parade.placing.intlOrdinal(context)}'
                                  ' ${context.loc.schoolPerformancePlace}',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
