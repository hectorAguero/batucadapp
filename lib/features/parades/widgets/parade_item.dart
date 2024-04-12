import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/animated_linear_gradient.dart';
import '../../../common_widgets/app_fade_in_image.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../../schools/school.dart';
import '../../schools/school_extensions.dart';
import '../parade.dart';
import '../parade_extension.dart';
import '../parades_tab_providers.dart';
import 'parade_item_bottom_row.dart';
import 'parade_item_sidebar.dart';
import 'parade_item_year_line.dart';

class ParadeItem extends ConsumerWidget {
  const ParadeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parade = ref.watch(currentParadeProvider);
    final medalColor = parade.medalColor(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: SizedBox(
        height: 240,
        child: Row(
          children: <Widget>[
            ParadeItemYearLine(
              year: parade.champion &&
                      parade.divisionNumber == SchoolDivision.especial
                  ? parade.paradeYear.toString()
                  : null,
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Card(
                  surfaceTintColor: medalColor,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
          ],
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
                          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: AppFadeInImage(
                            parade.school.imageUrl,
                            fit: BoxFit.cover,
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
        child: AnimatedLinearGradient(
          duration: const Duration(seconds: 2),
          colors: [
            medalColor.withOpacity(0.9),
            medalColor.withOpacity(0.1),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              parade.divisionNumber.shortName(context),
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

class ParadeItemTextContentHeader extends StatelessWidget {
  const ParadeItemTextContentHeader({
    required this.padding,
    required this.parade,
    super.key,
  });

  final Parade parade;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
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
                    '${parade.school.translatedName}\n',
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
          Text(
            parade.translatedEnredo.isNotEmpty
                ? parade.translatedEnredo
                : parade.details,
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

class ParadeItemTextContentDetails extends StatelessWidget {
  const ParadeItemTextContentDetails({
    required this.padding,
    required this.parade,
    super.key,
  });

  final Parade parade;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
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
                    text: 'Carnavalescos: ',
                    style: context.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: parade.translatedCarnavalescos.join(', '),
                    style: context.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                    text: 'Components: ',
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextSpan(
                    text: parade.components.toString(),
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: parade.numberOfFloats > 0 ? '\nFloats: ' : '',
                      ),
                      TextSpan(
                        text: parade.numberOfFloats > 0
                            ? parade.numberOfFloats.toString()
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfWings > 0 ? ' - Wings: ' : '',
                      ),
                      TextSpan(
                        text: parade.numberOfWings > 0
                            ? parade.numberOfWings.toString()
                            : '',
                      ),
                      TextSpan(
                        text: parade.numberOfTripods > 0 ? ' - Tripods: ' : '',
                      ),
                      TextSpan(
                        text: parade.numberOfTripods > 0
                            ? parade.numberOfTripods.toString()
                            : '',
                      ),
                    ],
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: context.colorScheme.onSurfaceVariant,
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
