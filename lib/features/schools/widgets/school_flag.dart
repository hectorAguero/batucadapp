import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/widgets/app_fade_in_image.dart';

class SchoolFlag extends ConsumerWidget {
  const SchoolFlag({
    required this.school,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
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
    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black26,
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
            blendMode: BlendMode.srcOver,
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: AppFadeInImage(
                school.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return Align(
              alignment: Alignment.topRight,
              child: CupertinoButton(
                child: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  switchInCurve: Curves.elasticIn,
                  switchOutCurve: Curves.elasticOut,
                  child: Icon(
                    school.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: school.isFavorite ? Colors.redAccent : Colors.white,
                    size: heartSize,
                  ),
                ),
                onPressed: () {
                  ref.read(schoolsProvider.notifier).toggleFavorite(school.id);
                },
              ),
            );
          },
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
