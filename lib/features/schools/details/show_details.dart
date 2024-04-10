import 'package:flutter/cupertino.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../school.dart';
import 'school_details_page.dart';

void showSchoolDetails(BuildContext context, School school) {
  WoltModalSheet.show<dynamic>(
    context: context,
    useSafeArea: false,
    pageListBuilder: (context) {
      return [
        SliverWoltModalSheetPage(
          hasTopBarLayer: false,
          isTopBarLayerAlwaysVisible: false,
          mainContentSlivers: [
            SliverToBoxAdapter(
              child: DecoratedBox(
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
                      for (final color in school.colorsCode)
                        color.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SchoolDetailsPage(
                    id: school.id,
                  ),
                ),
              ),
            ),
          ],
        ),
      ];
    },
  );
}
