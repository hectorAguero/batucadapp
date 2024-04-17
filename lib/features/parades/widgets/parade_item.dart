import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/app_animated_linear_gradient.dart';
import '../../../common_widgets/app_fade_in_image.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../schools/school_extensions.dart';
import '../parade.dart';
import '../parade_extension.dart';
import '../parades_tab_providers.dart';
import 'parade_item_bottom_row.dart';
import 'parade_item_sidebar.dart';

class ParadeItem extends ConsumerWidget {
  const ParadeItem({super.key});

  static const double height = 248;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parade = ref.watch(currentParadeProvider);
    final medalColor = parade.medalColor(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onLongPress: () {
          ref.read(paradeShowOriginalProvider.notifier).toggle();
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                medalColor.withOpacity(0.25),
                medalColor.withOpacity(0.4),
              ],
            ),
          ),
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                ParadeItemSideBar(
                  placing: parade.placing,
                  parade: parade,
                ),
                Expanded(
                  child: ParadeItemContent(parade: parade),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ParadeItemContent extends StatelessWidget {
  const ParadeItemContent({
    required this.parade,
    super.key,
  });

  final Parade parade;

  @override
  Widget build(BuildContext context) {
    final medalColor = parade.medalColor(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ParadeItemTextContentHeader(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              parade: parade,
            ),
            const Spacer(),
            ParadeItemTextContentDetails(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
              parade: parade,
            ),
            ParadeItemBottomRow(parade: parade),
            ColoredBox(
              color: medalColor,
              child: ClipRRect(
                child: SizedBox(
                  height: 24,
                  width: double.infinity,
                  child: parade.school.imageUrl.isEmpty
                      ? const SizedBox.shrink()
                      : ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: AppFadeInImage(
                            parade.school.imageUrl,
                            fadeInDuration: const Duration(milliseconds: 300),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const SizedBox();
                            },
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: ParadeItemBadge(parade: parade),
        ),
      ],
    );
  }
}

class ParadeItemBadge extends StatelessWidget {
  const ParadeItemBadge({
    required this.parade,
    super.key,
  });

  final Parade parade;

  @override
  Widget build(BuildContext context) {
    final medalColor = parade.medalColor(context);
    final divisionName = parade.divisionNumber.shortName(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
        ),
        border: Border(
          left: BorderSide(color: medalColor),
          bottom: BorderSide(color: medalColor),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
        ),
        child: AppAnimatedLinearGradient(
          duration: const Duration(seconds: 2),
          colors: [
            medalColor.withOpacity(0.9),
            medalColor.withOpacity(0.1),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              divisionName,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParadeItemTextContentHeader extends ConsumerWidget {
  const ParadeItemTextContentHeader({
    required this.padding,
    required this.parade,
    super.key,
  });

  final Parade parade;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOriginal = ref.watch(paradeShowOriginalProvider);
    final enredo = showOriginal ? parade.enredo : parade.translatedEnredo;
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    showOriginal
                        ? '${parade.school.name}\n'
                        : '${parade.school.translatedName}\n',
                    maxLines: 2,
                    style: context.textTheme.labelSmall!.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    strutStyle: const StrutStyle(
                      forceStrutHeight: true,
                      height: 1.1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    parade.divisionNumber.shortName(context),
                    style: context.textTheme.labelSmall!.copyWith(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                if (parade.translatedEnredo.isNotEmpty)
                  TextSpan(text: enredo)
                else
                  TextSpan(text: parade.details),
              ],
            ),
            style: context.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w700,
            ),
            strutStyle: const StrutStyle(
              forceStrutHeight: true,
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class ParadeItemTextContentDetails extends ConsumerWidget {
  const ParadeItemTextContentDetails({
    required this.padding,
    required this.parade,
    super.key,
  });

  final Parade parade;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOriginal = ref.watch(paradeShowOriginalProvider);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (parade.translatedCarnavalescos.isNotEmpty)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${context.loc.carnavalescos}:',
                    style: context.textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: showOriginal
                        ? parade.carnavalescos.join(', ')
                        : parade.translatedCarnavalescos.join(', '),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
              style: context.textTheme.labelMedium,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1.1,
              ),
              maxLines: 2,
            ),
          const SizedBox(height: 2),
          if (parade.components > 0)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${context.loc.schoolComponents}: ',
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: parade.components.toString(),
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    children: [
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: parade.numberOfFloats > 0
                            ? '${context.loc.floats}: '
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfFloats > 0
                            ? parade.numberOfFloats.toString()
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfWings > 0
                            ? ' - ${context.loc.wings}: '
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfWings > 0
                            ? parade.numberOfWings.toString()
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfTripods > 0
                            ? ' - ${context.loc.tripods}: '
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfTripods > 0
                            ? parade.numberOfTripods.toString()
                            : '',
                      ),
                    ],
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.labelSmall,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 1.1,
              ),
              maxLines: 2,
            )
          else if (parade.details.isNotEmpty && parade.enredo.isNotEmpty)
            Text(
              parade.details,
              style: context.textTheme.labelSmall,
              maxLines: 2,
            ),
        ],
      ),
    );
  }
}
