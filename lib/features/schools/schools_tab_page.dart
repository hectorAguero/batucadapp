import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:samba_public_app/extensions/hardcode_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/features/schools/schools_tab_providers.dart';
import 'package:samba_public_app/features/schools/widgets/school_card.dart';
import 'package:samba_public_app/features/schools/widgets/school_division_chips.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';
import 'package:samba_public_app/widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SchoolsTabPage extends ConsumerStatefulWidget {
  const SchoolsTabPage({super.key});

  static final route = GoRouteScrollTab(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const SchoolsTabPage(),
    ),
  );

  @override
  ConsumerState<SchoolsTabPage> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: <Widget>[
          SliverCrossAxisConstrained(
            maxCrossAxisExtent: largeScreen,
            child: AppCupertinoSliverNavBar(largeTitle: 'Schools'.hardcode),
          ),
          const SliverCrossAxisConstrained(
            maxCrossAxisExtent: largeScreen,
            child: SchoolDivisionChips(),
          ),
          Consumer(
            builder: (context, ref, child) {
              final schools = ref.watch(filteredSchoolsProvider);
              return SliverCrossAxisConstrained(
                maxCrossAxisExtent: largeScreen,
                child: SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  sliver: switch (schools) {
                    AsyncData(:final value) => SliverAlignedGrid.count(
                        crossAxisCount: context.querySize.getAxisCount(),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final school = value[index];
                          return SchoolCard(school: school);
                        },
                      ),
                    AsyncError(:final error) => SliverFillRemaining(
                        child: Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                    _ => const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
