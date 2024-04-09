import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/intl_extension.dart';
import '../../../extensions/media_query_context_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../schools/school.dart';
import '../../schools/school_extensions.dart';
import '../parade.dart';
import '../parade_extension.dart';
import '../parades_tab_providers.dart';

class ParadeItem extends ConsumerWidget {
  const ParadeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parade = ref.watch(currentParadeProvider);
    final order = parade.performanceOrder;
    final placing = parade.placing;
    final isFirstOftheYear = parade.placing == 1 &&
        parade.divisionNumber == SchoolDivision.values.first;
    return SafeArea(
      top: false,
      bottom: false,
      child: SizedBox(
        height: 280,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 32,
              height: double.infinity,
              child: Column(
                children: [
                  if (parade.placing == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          parade.paradeYear.toString(),
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
                        borderRadius: isFirstOftheYear
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
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Card(
                  surfaceTintColor: context.medalColor(placing),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      ParadeItemSideBar(placing: placing, parade: parade),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: context.medalColor(placing),
                                      ),
                                      bottom: BorderSide(
                                        color: context.medalColor(placing),
                                      ),
                                    ),
                                    color: context.colorScheme.surfaceContainer,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      parade.divisionNumber.shortName(context),
                                      style: context.textTheme.labelSmall!
                                          .copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: smallScreen,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 4,
                                ),
                                child: Text(
                                  parade.enredo,
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                parade.carnavalescos.join(', '),
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${context.loc.schoolComponents}:'
                                          ' ${parade.components}',
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Spacer(),
                            ColoredBox(
                              color:
                                  context.medalColor(placing).withOpacity(0.7),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: parade.date.intlShortDateTime(
                                          context,
                                          noYear: true,
                                        ),
                                      ),
                                      maxLines: 2,
                                      style: context.textTheme.titleSmall,
                                    ),
                                    const Spacer(),
                                    const SizedBox(width: 16),
                                    Text(
                                      '${order.ordinal(context)}'
                                      ' ${context.loc.schoolToParade}',
                                      style: context.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Container(
      width: 48,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: context.medalColor(placing),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                if (placing == 1 || placing == 2)
                  TextSpan(text: parade.getPlacingIcon),
                TextSpan(
                  text: parade.points.toString(),
                  style: context.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                          TextSpan(
                            text: parade.placing.ordinal(context),
                          ),
                          TextSpan(
                            text: ' ${context.loc.schoolPerformancePlace}',
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
