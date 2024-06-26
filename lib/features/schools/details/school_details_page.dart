import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../common_widgets/app_page_indicator.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/intl_extension.dart';
import '../../../core/extensions/string_extensions.dart';
import '../../../core/extensions/theme_of_context_extension.dart';
import '../../../theme/app_theme_colors.dart';
import '../../../theme/theme_mode_controller.dart';
import '../school.dart';
import '../school_extensions.dart';
import '../widgets/school_flag.dart';
import 'schools_details_controller.dart';

class SchoolDetailsPage extends ConsumerStatefulWidget {
  const SchoolDetailsPage({
    required this.id,
    super.key,
  });

  final int id;
  static const path = ':id';

  @override
  ConsumerState<SchoolDetailsPage> createState() => _SchoolDetailsPageState();
}

class _SchoolDetailsPageState extends ConsumerState<SchoolDetailsPage> {
  ValueNotifier<int> currentImage = ValueNotifier<int>(0);
  ValueNotifier<bool> showOriginal = ValueNotifier<bool>(false);

  static const int imageCount = 1;

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(schoolsDetailsControllerProvider(widget.id));

    return ListView(
      shrinkWrap: true,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                if (school.colors.isEmpty)
                  for (final _ in Iterable<int>.generate(2))
                    CupertinoDynamicColor.resolve(
                      CupertinoColors.systemGrey5,
                      context,
                    ),
                for (final color in school.colorsCode) color.withOpacity(0.5),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: InkWell(
              onLongPress: school.name == school.translatedName &&
                      school.symbols == school.translatedSymbols
                  ? null
                  : () => showOriginal.value = !showOriginal.value,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: ((constraints.maxWidth - 20) / 3) * 2,
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Stack(
                          children: [
                            PageView.builder(
                              clipBehavior: Clip.antiAlias,
                              itemCount: imageCount,
                              onPageChanged: (value) =>
                                  currentImage.value = value,
                              itemBuilder: (_, __) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
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
                              valueListenable: currentImage,
                              builder: (_, index, __) {
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
                    builder: (_, value, __) {
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
            ),
          ),
        ),
      ],
    );
  }
}

class SchoolDetailsText extends ConsumerStatefulWidget {
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
  ConsumerState<SchoolDetailsText> createState() => _SchoolDetailsTextState();
}

class _SchoolDetailsTextState extends ConsumerState<SchoolDetailsText> {
  void setColors() {
    final schoolColors = widget.school.colorsCode;
    if (schoolColors.isNotEmpty) {
      final colors = AppThemeColors(
        primary: schoolColors.first,
        name: widget.school.name,
        secondary: schoolColors.elementAtOrNull(1),
        tertiary: schoolColors.elementAtOrNull(2),
      );
      ref.read(appSelectedColorsProvider.notifier).setThemeColors(colors);
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = widget.school;
    final foundationDate = school.foundationDate;

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
                        style: context.headlineMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (widget.school.firstDivisionChampionships > 0)
                      AppCupertinoButton(
                        onPressed: null,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.school.firstDivisionChampionships}',
                              style: context.headlineMedium.copyWith(
                                color: context.customColors.goldColor,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                fontSize: 24,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                const Positioned(
                                  left: 1,
                                  top: 2,
                                  child: Icon(
                                    Icons.star,
                                    size: 24,
                                    color: Colors.black26,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: context.customColors.goldColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (widget.school.symbols.isNotEmpty)
                  SchoolTextTile(
                    icon: Icons.music_note_outlined,
                    title: '${context.loc.schoolSymbols}: ',
                    content: widget.showOriginal
                        ? widget.school.symbols.join(', ')
                        : widget.school.translatedSymbols.join(', '),
                  ),
                if (foundationDate != null)
                  SchoolTextTile(
                    icon: Icons.date_range_outlined,
                    title: '${context.loc.schoolFoundation}: ',
                    content: foundationDate.intlShort(context),
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    SizedBox(
                      width: 32,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Tooltip(
                            message: widget.school.translatedColors.join(', '),
                            onTriggered: setColors,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                for (final (index, colorCode)
                                    in widget.school.colorsCode.indexed)
                                  Container(
                                    height: 32,
                                    width: 32,
                                    margin:
                                        EdgeInsets.only(bottom: index * 12.0),
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
                          );
                        },
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
              style: context.bodyLarge,
            ),
          ],
          style: context.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
