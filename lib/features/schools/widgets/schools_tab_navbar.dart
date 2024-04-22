import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../common_widgets/app_cupertino_button.dart';
import '../../../common_widgets/app_cupertino_sliver_navigation_bar.dart';
import '../../../core/extensions/app_localization_extension.dart';
import '../../../core/extensions/hardcoded_extension.dart';
import '../../../utils/app_loggers.dart';
import '../../../utils/screen_size.dart';

class SchoolsTabNavBar extends StatelessWidget {
  const SchoolsTabNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverCrossAxisConstrained(
      maxCrossAxisExtent: ScreenSize.lg.value,
      child: AppCupertinoSliverNavigationBar(
        largeTitle: context.loc.schoolsTitle,
        leading: PullDownButton(
          // menuOffset: context.screenSize.currentRailWidth,
          itemBuilder: (context) => [
            // TODO(hectorAguero): Should get this from the Data
            PullDownMenuItem.selectable(
              title: '🇧🇷 Rio de Janeiro'.hardcoded,
              selected: true,
              onTap: () {
                logViews.info('Selected Rio de Janeiro');
              },
            ),
          ],
          buttonBuilder: (context, showMenu) => AppCupertinoButton(
            onPressed: showMenu,
            child: const Icon(CupertinoIcons.ellipsis_circle),
          ),
        ),
      ),
    );
  }
}
