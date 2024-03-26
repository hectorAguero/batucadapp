import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samba_public_app/common_widgets/app_cupertino_sliver_nav_bar.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';

class ParadesTab extends StatelessWidget {
  const ParadesTab({super.key});

  static final route = GoRouteScrollTab(
    path: '/parades',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const ParadesTab(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppCupertinoSliverNavBar(
            largeTitle: context.loc.paradesTitle,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Parade $index'.hardcoded),
                  onTap: () {},
                );
              },
              itemCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
