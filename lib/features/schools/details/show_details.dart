import 'package:flutter/cupertino.dart';
import 'package:samba_public_app/features/schools/details/school_details_page.dart';
import 'package:samba_public_app/features/schools/school.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
                      CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGrey5,
                        context,
                      ),
                      if (school.colors.isNotEmpty)
                        school.colors.first.withOpacity(0.5)
                      else
                        CupertinoDynamicColor.resolve(
                          CupertinoColors.systemGrey5,
                          context,
                        ),
                      if (school.colors.length > 1)
                        school.colors[1].withOpacity(0.5),
                      if (school.colors.length > 2)
                        school.colors[2].withOpacity(0.5),
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
