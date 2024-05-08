import 'package:const_date_time/const_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../../common_widgets/app_animation_wrapper.dart';
import '../../common_widgets/app_async_widget.dart';
import '../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../common_widgets/app_loading_indicator.dart';
import '../../core/extensions/app_localization_extension.dart';
import '../../utils/debouncer.dart';
import '../../utils/immutable_list.dart';
import '../../utils/screen_size.dart';
import '../home/home_page_controller.dart';
import '../schools/school.dart';
import 'parade.dart';
import 'parades_tab_controller.dart';
import 'widgets/parade_item.dart';
import 'widgets/parade_item_year_line.dart';

class ParadesTabPage extends ConsumerStatefulWidget {
  const ParadesTabPage({super.key});

  static const tab = HomeTab.parades;
  static const path = '/parades';

  @override
  ConsumerState<ParadesTabPage> createState() => _ParadesTabPageState();
}

class _ParadesTabPageState extends ConsumerState<ParadesTabPage> {
  final _debouncer = Debouncer();
  final _listController = ListController();
  late final ScrollController controller = PrimaryScrollController.of(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(_loadMoreListener);
    });
  }

  void _loadMoreListener() {
    final position = controller.position;
    if (position.pixels == position.maxScrollExtent) {
      if (!ref.read(paradesTabReachedLimitProvider)) {
        _debouncer
            .run(ref.read(paradesTabControllerProvider.notifier).fetchNextPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: ScreenSize.md.value,
            child: AppCupertinoSliverNavigationBar(
              largeTitle: context.loc.paradesTitle,
            ),
          ),
          AppAsyncSliverWidget(
            asyncValue: ref.watch(paradesTabControllerProvider),
            onErrorRetry: () async =>
                Future.delayed(const Duration(milliseconds: 500), () {
              ref.invalidate(paradesTabControllerProvider);
            }),
            loadingSliver: SliverCrossAxisConstrained(
              maxCrossAxisExtent: ScreenSize.md.value,
              child: SliverSkeletonizer(
                child: SuperSliverList.builder(
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: index != 0
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(top: 24),
                      child: SizedBox(
                        height: ParadeItem.height,
                        child: Row(
                          children: [
                            ParadeItemYearLine(
                              year: index == 0 ? '2222' : null,
                            ),
                            ProviderScope(
                              overrides: [
                                currentParadeProvider.overrideWithValue(
                                  _paradeSkeleton(index + 1),
                                ),
                              ],
                              child: const Expanded(
                                child: ParadeItem(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            child: (value) => SliverCrossAxisConstrained(
              maxCrossAxisExtent: ScreenSize.md.value,
              child: SuperSliverList.builder(
                itemCount: value.length,
                listController: _listController,
                itemBuilder: (_, index) {
                  final parade = value[index];

                  return ProviderScope(
                    overrides: [
                      currentParadeProvider.overrideWithValue(value[index]),
                    ],
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: index != 0
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(top: 24),
                        child: SizedBox(
                          height: ParadeItem.height,
                          child: Row(
                            children: [
                              ParadeItemYearLine(
                                year: parade.champion &&
                                        parade.divisionNumber ==
                                            SchoolDivision.especial
                                    ? parade.paradeYear.toString()
                                    : null,
                              ),
                              Expanded(
                                child: AppAnimationWrapper(
                                  start: value.length > 10 ? 0.6 : 1.0,
                                  child: const ParadeItem(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          AppLoadingIndicator(
            showLoading: !ref.watch(paradesTabReachedLimitProvider),
            sliver: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _listController.dispose();
    controller.removeListener(_loadMoreListener);
    super.dispose();
  }
}

Parade _paradeSkeleton(int index) => Parade(
      id: index,
      schoolId: index,
      carnivalId: index,
      carnivalName: "",
      enredo: "",
      carnavalescos: ImmutableList(const []),
      division: "BoneMock.name,",
      divisionNumber: SchoolDivision.especial,
      subdivisionNumber: index,
      paradeYear: const ConstDateTime(2024).year,
      date: const ConstDateTime(2024),
      championParade: const ConstDateTime(2024),
      components: index,
      numberOfWings: index,
      numberOfFloats: index,
      numberOfTripods: index,
      placing: index,
      relegated: false,
      promoted: false,
      champion: index == 1,
      performanceOrder: index,
      performanceDay: index,
      points: index.toDouble(),
      details: "BoneMock.longParagraph,",
      translatedCarnivalName: "BoneMock.address,",
      translatedEnredo: "BoneMock.address,",
      translatedDivision: "BoneMock.address,",
      translatedCarnavalescos: ImmutableList(const []),
      school: const School(
        id: 1,
        name: "name",
        translatedName: "translatedName",
        imageUrl: "",
        foundationDate: ConstDateTime(2024),
        godmotherSchool: "godmotherSchool",
        colors: IListConst(["colors"]),
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
      ),
    );
