import 'package:flutter/material.dart';

import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/intl_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
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
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text.rich(
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
                              text:
                                  '${parade.placing.intlOrdinal(context)} ${context.loc.schoolPerformancePlace}',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
