import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../../extensions/app_localization_extension.dart';
import '../../../extensions/hardcoded_extension.dart';
import '../../../extensions/media_query_context_extension.dart';

class SchoolsTabNavBar extends StatelessWidget {
  const SchoolsTabNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverCrossAxisConstrained(
      maxCrossAxisExtent: largeScreen,
      child: AppCupertinoSliverNavigationBar(
        largeTitle: context.loc.schoolsTitle,
        leading: PullDownButton(
          menuOffset: context.querySize.currentRailWidth,
          itemBuilder: (context) => [
            // TODO(hectorAguero): Should get this from the API
            PullDownMenuItem.selectable(
              title: '🇧🇷 Rio de Janeiro'.hardcoded,
              selected: true,
              onTap: () {},
            ),
          ],
          buttonBuilder: (context, showMenu) => AppCupertinoButton(
            onPressed: showMenu,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.ellipsis_circle),
          ),
        ),
      ),
    );
  }
}
