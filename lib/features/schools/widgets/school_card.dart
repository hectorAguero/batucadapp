import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/widgets/app_fade_in_image.dart';

class SchoolCard extends ConsumerWidget {
  const SchoolCard({
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    super.key,
  });

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final school = ref.watch(currentSchoolProvider);
    final colorScheme = context.colorScheme;
    return Card(
      margin: margin,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.75, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: const GradientRotation(0.4),
            colors: [
              colorScheme.onInverseSurface,
              school.colors.first.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
                    child: SizedBox(
                      height: 160,
                      child: AppFadeInImage(
                        school.imageUrl,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
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
                            color: school.isFavorite
                                ? Colors.redAccent
                                : Colors.white,
                          ),
                        ),
                        onPressed: () {
                          ref
                              .read(schoolsProvider.notifier)
                              .toggleFavorite(school.id);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      school.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: colorScheme.onSurface,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 16),
                    child: Text(
                      school.currentDivision.fullName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w100,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, right: 16),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Learn More',
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
