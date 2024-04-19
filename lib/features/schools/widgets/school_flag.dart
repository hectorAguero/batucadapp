import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/app_fade_in_image.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../school.dart';
import '../schools_tab_providers.dart';

class SchoolFlag extends ConsumerWidget {
  const SchoolFlag({
    required this.school,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.leading,
    this.heartSize = 24,
    super.key,
  });

  final School school;
  final BorderRadius borderRadius;
  final Widget? leading;
  final double heartSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoriteSchoolsProvider.select((v) => v.contains('${school.id}')),
    );
    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ).createShader(
                Rect.fromPoints(
                  Offset(bounds.width, 0),
                  Offset(
                    bounds.width - 40,
                    40,
                  ),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: school.imageUrl.isNotEmpty
                  ? AppFadeInImage(
                      school.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : EmptyImage(colors: school.colorsCode),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CupertinoButton(
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: isFavorite
                  ? Icon(
                      key: const ValueKey(true),
                      CupertinoIcons.heart_fill,
                      color: Colors.redAccent,
                      size: heartSize,
                    )
                  : Icon(
                      key: const ValueKey(false),
                      CupertinoIcons.heart,
                      color: Colors.white,
                      size: heartSize,
                    ),
            ),
            onPressed: () {
              ref
                  .read(favoriteSchoolsProvider.notifier)
                  .toggleFavorite(school.id);
            },
          ),
        ),
        if (leading != null)
          Align(
            alignment: Alignment.topLeft,
            child: leading,
          ),
      ],
    );
  }
}

class EmptyImage extends StatelessWidget {
  const EmptyImage({required this.colors, super.key});

  final IList<Color> colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (colors.isEmpty) ...[
              context.colorScheme.primaryContainer,
              context.colorScheme.secondaryContainer,
            ] else
              ...colors,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.photo,
            size: 48,
            color: context.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(height: 8),
          Text(
            context.loc.noImage,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
