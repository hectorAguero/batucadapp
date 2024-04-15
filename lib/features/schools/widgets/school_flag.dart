import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/app_fade_in_image.dart';
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
              child: AppFadeInImage(
                school.imageUrl,
                fit: BoxFit.cover,
              ),
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
