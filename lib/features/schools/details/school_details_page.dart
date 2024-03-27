import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:samba_public_app/common_widgets/app_page_indicator.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/intl_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/features/schools/details/schools_details_providers.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:samba_public_app/features/schools/schools_extensions.dart';
import 'package:samba_public_app/features/schools/widgets/school_flag.dart';

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

  static const int imageCount = 1;

  @override
  Widget build(BuildContext context) {
    final school = ref.watch(selectedSchoolProvider(widget.id));
    return Column(
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
        SchoolDetailsText(school: school),
      ],
    );
  }
}

class SchoolDetailsText extends StatelessWidget {
  const SchoolDetailsText({required this.school, super.key});

  final School school;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  school.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: (16 * school.colors.length) + 16.0,
                height: 32,
                child: Tooltip(
                  message: school.colorNames.join(', '),
                  child: Stack(
                    children: [
                      for (final (index, color) in school.colors.indexed)
                        Container(
                          height: 32,
                          width: 32,
                          margin: EdgeInsets.only(left: index * 16.0),
                          decoration: BoxDecoration(
                            color: color,
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
          const SizedBox(height: 8),
          SchoolTextTile(
            icon: Icons.music_note_outlined,
            title: '${context.loc.schoolSymbols}: ',
            content: school.symbols.join(', '),
          ),
          const SizedBox(height: 8),
          SchoolTextTile(
            icon: Icons.date_range_outlined,
            title: '${context.loc.schoolFoundation}: ',
            content: school.foundationDate.intlShort(context),
          ),
          const SizedBox(height: 8),
          if (school.godmotherSchool.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SchoolTextTile(
                icon: Icons.school_outlined,
                title: '${context.loc.schoolGodmother}: ',
                content: school.godmotherSchool,
              ),
            ),
          SchoolTextTile(
            icon: Icons.star_border_outlined,
            title: '${context.loc.schoolLeague}: ',
            content: school.league.name.toUpperCase(),
            contentTooltip: school.league.fullName(context),
          ),
          const SizedBox(height: 8),
          SchoolTextTile(
            icon: Icons.sports_soccer_outlined,
            title: '${context.loc.schoolDivision}: ',
            content: school.currentDivision.fullName(context),
          ),
          const SizedBox(height: 8),
        ],
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
    super.key,
  });

  final IconData icon;
  final String title;
  final String content;
  final String? contentTooltip;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
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
    );
  }
}
