import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/app_loading_indicator.dart';
import '../../utils/debouncer.dart';
import '../home/home_page_controller.dart';
import 'schools_tab_controller.dart';
import 'widgets/school_filter_chips.dart';
import 'widgets/schools_tab_body.dart';
import 'widgets/schools_tab_navbar.dart';
import 'widgets/schools_tab_search_header.dart';

class SchoolsTabPage extends ConsumerStatefulWidget {
  const SchoolsTabPage({super.key});

  static const tab = HomeTab.schools;
  static const path = '/schools';

  @override
  ConsumerState<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTabPage> {
  final _debouncer = Debouncer();
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
      if (!ref.read(schoolReachedMaxProvider)) {
        _debouncer.run(
          ref.read(schoolsTabControllerProvider.notifier).fetchNextPage,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => focus.hasFocus ? focus.unfocus() : null,
        child: CustomScrollView(
          controller: controller,
          slivers: const <Widget>[
            SchoolsTabNavBar(),
            SchoolsTabSearchHeader(),
            SchoolFilterChips(),
            SchoolsTabBody(),
            SchoolsTabLoadMoreIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    controller.removeListener(_loadMoreListener);
    super.dispose();
  }
}

class SchoolsTabLoadMoreIndicator extends ConsumerWidget {
  const SchoolsTabLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reachedLimit = ref.watch(schoolReachedMaxProvider);
    final isNotEmpty = ref.watch(filteredSchoolsProvider).isNotEmpty;
    final isFiltered = ref.watch(filteredSchoolsProvider).length !=
        ref.watch(schoolsTabControllerProvider).valueOrNull?.length;

    return AppLoadingIndicator(
      showLoading: !reachedLimit && isNotEmpty && !isFiltered,
      sliver: true,
    );
  }
}
