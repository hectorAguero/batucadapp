import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/intl_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/parades/parade_extension.dart';
import 'package:samba_public_app/features/parades/parades_tab_providers.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/school_extensions.dart';

class ParadeItem extends ConsumerWidget {
  const ParadeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parade = ref.watch(currentParadeProvider);
    final isFirstOftheYear = parade.placing == 1 &&
        parade.divisionNumber == SchoolDivision.values.first;
    return SizedBox(
      height: 280,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 36,
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
                surfaceTintColor: switch (parade.placing) {
                  1 => context.customColors.goldColor!,
                  2 => context.customColors.silverColor!,
                  _ => context.colorScheme.secondary,
                },
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: switch (parade.placing) {
                        1 => context.customColors.goldColor,
                        2 => context.customColors.silverColor,
                        _ => context.colorScheme.secondaryContainer,
                      },
                      child: Column(
                        children: [
                          if (parade.placing == 1 || parade.placing == 2)
                            Text(
                              parade.getPlacingIcon,
                              style: TextStyle(
                                fontSize: 48,
                                color: context.colorScheme.onSurface,
                              ),
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
                                        text: '${parade.placing}',
                                        style: context.textTheme.headlineLarge!
                                            .copyWith(
                                          color: context.colorScheme.onSurface,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            context.loc.schoolPerformancePlace,
                                        style: context.textTheme.headlineSmall!
                                            .copyWith(
                                          color: context.colorScheme.onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                    style: context.textTheme.headlineLarge!
                                        .copyWith(
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                      color: switch (parade.placing) {
                                        1 => context.customColors.goldColor!,
                                        2 => context.customColors.silverColor!,
                                        _ => context
                                            .colorScheme.secondaryContainer,
                                      },
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      color: switch (parade.placing) {
                                        1 => context.customColors.goldColor!,
                                        2 => context.customColors.silverColor!,
                                        _ => context
                                            .colorScheme.secondaryContainer,
                                      },
                                      width: 2,
                                    ),
                                  ),
                                  color: context.colorScheme.surfaceContainer,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    parade.divisionNumber.shortName(context),
                                    style: context.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: smallScreen,
                              ),
                              child: Text(
                                parade.enredo,
                                style: context.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              parade.carnavalescos.join(', '),
                              style: context.textTheme.titleMedium!.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${context.loc.schoolComponents}:'
                                        ' ${parade.components}',
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      color:
                                          context.colorScheme.onSurfaceVariant,
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
                            color: switch (parade.placing) {
                              1 => context.customColors.goldColor!,
                              2 => context.customColors.silverColor!,
                              _ => context.colorScheme.secondaryContainer,
                            }
                                .withOpacity(0.7),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text:
                                            '${parade.date.intlShortDateTime(context)}'
                                            ' - ${parade.performanceOrder.ordinal(context)}'
                                            ' ${context.loc.schoolToParade}',
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.titleMedium,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${context.loc.schoolScore}:',
                                        ),
                                        const WidgetSpan(
                                          child: SizedBox(width: 8),
                                        ),
                                        TextSpan(
                                          text: parade.points.toString(),
                                        ),
                                      ],
                                    ),
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
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
    );
  }
}
