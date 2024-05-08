import 'package:const_date_time/const_date_time.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_animation_wrapper.dart';
import '../../../common_widgets/app_async_widget.dart';
import '../../../core/extensions/js_bottom_padding_extension.dart'
    if (dart.library.js_interop) '../../../core/extensions/js_bottom_padding_extension_web.dart';
import '../../../utils/immutable_list.dart';
import '../../../utils/screen_size.dart';
import '../school.dart';
import '../schools_tab_controller.dart';
import 'school_card.dart';
import 'schools_empty_list.dart';

class SchoolsTabBody extends ConsumerWidget {
  const SchoolsTabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverSafeArea(
      top: false,
      sliver: AppAsyncSliverWidget(
        asyncValue: ref.watch(schoolsTabControllerProvider),
        onErrorRetry: () => ref.invalidate(schoolsTabControllerProvider),
        loadingSliver: SliverCrossAxisConstrained(
          maxCrossAxisExtent: ScreenSize.lg.value,
          child: SliverPadding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16 + rightInset(),
            ),
            sliver: SliverSkeletonizer(
              child: SliverSchoolsList(
                schools: ImmutableList(
                  [for (var i = 0; i < 10; i++) _schoolSkeleton],
                ),
              ),
            ),
          ),
        ),
        child: (_) => Consumer(
          builder: (_, ref, __) {
            final schools = ref.watch(filteredSchoolsProvider);

            return SliverCrossAxisConstrained(
              maxCrossAxisExtent: ScreenSize.lg.value,
              child: SliverPadding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16 + rightInset(),
                ),
                sliver: SliverAnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: schools.isEmpty
                      ? const SchoolsEmptyList()
                      : SliverSchoolsList(schools: schools),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SliverSchoolsList extends StatelessWidget {
  const SliverSchoolsList({
    required this.schools,
    super.key,
  });

  final ImmutableList<School> schools;

  @override
  Widget build(BuildContext context) {
    return SliverDynamicHeightGridView(
      itemCount: schools.length,
      crossAxisCount: context.screenSize.defaultCrossAxisCount,
      builder: (_, index) {
        final school = schools[index];

        return AppAnimationWrapper(
          start: schools.length > 10 ? 0.6 : 1.0,
          child: ProviderScope(
            overrides: [
              currentSchoolProvider.overrideWithValue(school),
            ],
            child: const SchoolCard(),
          ),
        );
      },
    );
  }
}

School get _schoolSkeleton => const School(
      id: 1,
      name: "name",
      translatedName: "translatedName",
      imageUrl: "",
      foundationDate: ConstDateTime(2024),
      godmotherSchool: "godmotherSchool",
      colors: IListConst([]),
      colorsCode: IListConst([]),
      symbols: IListConst([]),
      carnivalCategory: SchoolCategory.escolasDeSamba,
      currentDivision: SchoolDivision.especial,
      divisionNumber: 1,
      subdivisionNumber: 1,
      firstDivisionChampionships: 1,
      country: "country",
      leagueLocation: "leagueLocation",
      lastPosition: 1,
      translatedColors: IListConst([]),
      translatedSymbols: IListConst([]),
      translatedGodmotherSchool: "translatedGodmotherSchool",
      translatedLeagueLocation: "translatedLeagueLocation",
      translatedCountry: "translatedCountry",
    );
