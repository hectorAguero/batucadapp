import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/schools/details/show_details.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_flag.dart';

class SchoolCard extends ConsumerWidget {
  const SchoolCard({
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    super.key,
  });

  final EdgeInsets margin;

  static const double cardMaxWidth = 400;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final school = ref.watch(currentSchoolProvider);
    return Padding(
      padding: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showSchoolDetails(context, school);
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CupertinoDynamicColor.resolve(
                    CupertinoColors.systemGrey5,
                    context,
                  ),
                  if (school.colors.isNotEmpty)
                    school.colors.first.withOpacity(0.5)
                  else
                    CupertinoDynamicColor.resolve(
                      CupertinoColors.systemGrey5,
                      context,
                    ),
                  if (school.colors.length > 1)
                    school.colors[1].withOpacity(0.5),
                  if (school.colors.length > 2)
                    school.colors[2].withOpacity(0.5),
                ],
              ),
            ),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SchoolFlag(school: school),
                ),
                SchoolInfoCard(school: school),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SchoolInfoCard extends StatelessWidget {
  const SchoolInfoCard({
    required this.school,
    super.key,
  });

  final School school;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Text(
              '${school.name}${context.querySize.isMediumScreen ? '\n' : ' '}',
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 16),
                child: Text(
                  school.currentDivision.fullName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8),
                  child: TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(
                      ref
                          .watch(selectedSchoolSortProvider)
                          .getSortedValue(school),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
