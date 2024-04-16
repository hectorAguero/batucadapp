import 'package:flutter/material.dart';

import '../../../common_widgets/app_animated_linear_gradient.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/intl_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../parade.dart';
import '../parade_extension.dart';

class ParadeItemBottomRow extends StatelessWidget {
  const ParadeItemBottomRow({
    required this.parade,
    super.key,
  });

  final Parade parade;

  @override
  Widget build(BuildContext context) {
    final medalColor = parade.medalColor(context);
    final day = parade.performanceDay.intlOrdinal(context);
    final order = parade.performanceOrder.intlOrdinal(context);
    return AppAnimatedLinearGradient(
      duration: const Duration(seconds: 10),
      colors: [
        if (parade.school.colorsCode.length > 1)
          for (final color in parade.school.colorsCode) color.withOpacity(0.7)
        else
          for (final _ in Iterable<int>.generate(2)) medalColor,
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Row(
          children: [
            Text.rich(
              maxLines: 2,
              TextSpan(
                style: context.textTheme.labelMedium,
                children: [
                  TextSpan(text: '$day${context.loc.day} '),
                  TextSpan(text: parade.date.intlTime(context)),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(width: 16),
            Text(
              '$order${context.loc.schoolToParade}',
              style: context.textTheme.labelMedium!.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
