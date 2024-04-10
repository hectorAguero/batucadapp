import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/intl_extension.dart';
import '../../../extensions/media_query_context_extension.dart';
import '../../../extensions/string_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../details/show_details.dart';
import '../school.dart';
import '../school_extensions.dart';
import '../school_sort.dart';
import '../schools_tab_providers.dart';
import 'school_flag.dart';

class SchoolCard extends ConsumerStatefulWidget {
  const SchoolCard({
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    super.key,
  });

  final EdgeInsets margin;

  static const double cardMaxWidth = 400;

  @override
  ConsumerState<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends ConsumerState<SchoolCard> {
  ValueNotifier<bool> showOriginal = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(currentSchoolProvider);
    return Padding(
      padding: widget.margin,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            showSchoolDetails(context, school);
          },
          onLongPress: school.name == school.translatedName
              ? null
              : () {
                  showOriginal.value = !showOriginal.value;
                },
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
                ValueListenableBuilder(
                  valueListenable: showOriginal,
                  builder: (context, value, child) {
                    return SchoolInfoCard(
                      school: school,
                      showOriginal: value,
                    );
                  },
                ),
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
    required this.showOriginal,
    super.key,
  });

  final School school;
  final bool showOriginal;

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
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              key: ValueKey(showOriginal),
              child: !showOriginal
                  ? Text(
                      '${school.translatedName}'
                      '${context.querySize.isNotSmallNorMedium ? '\n' : ' '}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  : Text(
                      '${school.name}'
                      '${context.querySize.isNotSmallNorMedium ? '\n' : ' '}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 16),
                child: Text.rich(
                  TextSpan(
                    text: school.currentDivision.fullName(context),
                    children: [
                      if (school.lastPosition == 1)
                        const TextSpan(
                          text: ' 🏆',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
            ),
            Flexible(
              child: Consumer(
                builder: (context, ref, child) {
                  final sort = ref.watch(selectedSchoolSortProvider);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 8),
                    child: TextButton(
                      onPressed: null,
                      style: TextButton.styleFrom(
                        textStyle:
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                  wordSpacing: -1,
                                  letterSpacing: -0.5,
                                ),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: sort.getSortedValue(school, context),
                            ),
                            if (sort == SchoolSort.location)
                              TextSpan(text: ', ${school.leagueLocation}'),
                          ],
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension SelectedSchoolSortExtension on SchoolSort {
  String getSortedValue(School school, BuildContext context) => switch (this) {
        (SchoolSort.lastPerformance) =>
          '${school.lastPosition.intlOrdinal(context)}'
              ' ${context.loc.schoolPerformancePlace.capitalize}',
        (SchoolSort.location) =>
          CountryLocalizations.of(context)!.countryName(countryCode: 'BR')!,
        _ => school.foundationDate.intlShort(context)
      };
}
