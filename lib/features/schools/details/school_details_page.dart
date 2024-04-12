import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/app_page_indicator.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/intl_extension.dart';
import '../../../extensions/string_extension.dart';
import '../../../extensions/theme_of_context_extension.dart';
import '../school.dart';
import '../school_extensions.dart';
import '../widgets/school_flag.dart';
import 'schools_details_providers.dart';

class SchoolDetailsPage extends ConsumerStatefulWidget {
  const SchoolDetailsPage({
    required this.id,
    this.isModalSheet = false,
    super.key,
  });

  final int id;
  final bool isModalSheet;

  static GoRoute route = GoRoute(
    path: 'details/:id',
    builder: (context, state) {
      final pathParams = state.extra! as Map<String, dynamic>;
      final id = pathParams['id'] as int;
      return SchoolDetailsPage(id: id);
    },
  );

  @override
  ConsumerState<SchoolDetailsPage> createState() => _SchoolDetailsPageState();
}

class _SchoolDetailsPageState extends ConsumerState<SchoolDetailsPage> {
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  ValueNotifier<bool> showOriginal = ValueNotifier<bool>(false);

  static const int imageCount = 1;

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(selectedSchoolProvider(widget.id));
    return InkWell(
      onLongPress: school.name == school.translatedName &&
              school.symbols == school.translatedSymbols
          ? null
          : () {
              showOriginal.value = !showOriginal.value;
            },
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: ((constraints.maxWidth - 20) / 3) * 2,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  children: [
                    PageView.builder(
                      clipBehavior: Clip.antiAlias,
                      itemCount: imageCount,
                      onPageChanged: (value) => currentPage.value = value,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            child: SchoolFlag(
                              heartSize: 32,
                              school: school,
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: currentPage,
                      builder: (context, index, child) {
                        return AppPageIndicator(
                          pageCount: imageCount,
                          currentPage: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: showOriginal,
            builder: (context, value, child) {
              return SchoolDetailsText(
                school: school,
                showOriginal: value,
                onTranslate: () {
                  showOriginal.value = !showOriginal.value;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SchoolDetailsText extends StatefulWidget {
  const SchoolDetailsText({
    required this.school,
    required this.showOriginal,
    required this.onTranslate,
    super.key,
  });

  final School school;
  final bool showOriginal;
  final VoidCallback onTranslate;

  @override
  State<SchoolDetailsText> createState() => _SchoolDetailsTextState();
}

class _SchoolDetailsTextState extends State<SchoolDetailsText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: Padding(
        key: ValueKey(widget.showOriginal),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.showOriginal
                            ? '${widget.school.translatedName}${'\n'}'
                            : '${widget.school.name}${'\n'}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headlineMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (widget.school.firstDivisionChampionships > 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          elevation: 0,
                          disabledBackgroundColor: Colors.transparent,
                        ),
                        onPressed: null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  const Positioned(
                                    left: 1,
                                    top: 2,
                                    child: Icon(
                                      Icons.star,
                                      size: 32,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 32,
                                    color: context.customColors.goldColor,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${widget.school.firstDivisionChampionships}',
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: context.customColors.goldColor,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SchoolTextTile(
                  icon: Icons.music_note_outlined,
                  title: '${context.loc.schoolSymbols}: ',
                  content: widget.showOriginal
                      ? widget.school.symbols.join(', ')
                      : widget.school.translatedSymbols.join(', '),
                ),
                if (widget.school.foundationDate != null)
                  SchoolTextTile(
                    icon: Icons.date_range_outlined,
                    title: '${context.loc.schoolFoundation}: ',
                    content: widget.school.foundationDate!.intlShort(context),
                  ),
                if (widget.school.godmotherSchool.isNotEmpty)
                  SchoolTextTile(
                    icon: Icons.school_outlined,
                    title: '${context.loc.schoolGodmother}: ',
                    content: widget.showOriginal
                        ? widget.school.godmotherSchool
                        : widget.school.translatedGodmotherSchool,
                  ),
                SchoolTextTile(
                  icon: Icons.leaderboard_outlined,
                  title: '${context.loc.schoolDivision}: ',
                  content: widget.school.currentDivision.fullName(context),
                ),
                SchoolTextTile(
                  icon: Icons.sports_soccer_outlined,
                  title: '${context.loc.schoolSortByLastPerformance}: ',
                  content: '${widget.school.lastPosition.intlOrdinal(context)} '
                      '${context.loc.schoolPerformancePlace.capitalize}',
                ),
                SchoolTextTile(
                  icon: CupertinoIcons.flag,
                  title: '',
                  content: widget.showOriginal
                      ? '${widget.school.country},'
                          ' ${widget.school.leagueLocation}'
                      : '${widget.school.translatedCountry},'
                          ' ${widget.school.translatedLeagueLocation}',
                ),
                const SizedBox(height: 8),
              ],
            ),
            if (widget.school.translatedName != widget.school.name ||
                widget.school.symbols != widget.school.translatedSymbols)
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 32,
                        child: Tooltip(
                          message: widget.school.translatedColors.join(', '),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              for (final (index, colorCode)
                                  in widget.school.colorsCode.indexed)
                                Container(
                                  height: 32,
                                  width: 32,
                                  margin: EdgeInsets.only(bottom: index * 12.0),
                                  decoration: BoxDecoration(
                                    color: colorCode,
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SchoolTextTile extends StatelessWidget {
  const SchoolTextTile({
    required this.icon,
    required this.title,
    required this.content,
    this.contentTooltip,
    this.padding = const EdgeInsets.only(bottom: 8),
    super.key,
  });

  final IconData icon;
  final String title;
  final String content;
  final String? contentTooltip;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Icon(icon, size: 16),
              alignment: PlaceholderAlignment.middle,
            ),
            const WidgetSpan(child: SizedBox(width: 4)),
            TextSpan(text: title),
            TextSpan(
              text: content,
              style: context.textTheme.bodyLarge,
            ),
          ],
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
