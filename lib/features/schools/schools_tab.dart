import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samba_public_app/router/router.dart';

class SchoolsTab extends ConsumerStatefulWidget {
  const SchoolsTab({super.key});

  static final route = AppBaseRoute(
    path: '/schools',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const SchoolsTab(),
    ),
  );

  @override
  ConsumerState<SchoolsTab> createState() => _SchoolsTabState();
}

class _SchoolsTabState extends ConsumerState<SchoolsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: PrimaryScrollController.of(context),
        slivers: <Widget>[
          const SliverAppBar(
            title: Text('Schools'),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('School $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
