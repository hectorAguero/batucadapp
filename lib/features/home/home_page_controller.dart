import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_page.dart';
import 'package:samba_public_app/features/parades/parades_tab.dart';
import 'package:samba_public_app/features/schools/schools_tab_page.dart';

part 'home_page_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectedHomeTabIndex extends _$SelectedHomeTabIndex {
  @override
  int build() {
    return 0;
  }

  void select(int index) {
    state = index;
  }
}

enum TabDestination {
  instruments,
  parades,
  schools;

  String get path => switch (this) {
        TabDestination.instruments => InstrumentsTabPage.route.path,
        TabDestination.parades => ParadesTab.route.path,
        TabDestination.schools => SchoolsTabPage.route.path,
      };

  String label(BuildContext context) => switch (this) {
        TabDestination.instruments => context.loc.instrumentsTitle,
        TabDestination.parades => context.loc.paradesTitle,
        TabDestination.schools => context.loc.schoolsTitle
      };

  IconData get icon => switch (this) {
        TabDestination.instruments => Icons.music_note,
        TabDestination.parades => Icons.flag,
        TabDestination.schools => Icons.school
      };

  IconData get selectedIcon => switch (this) {
        TabDestination.instruments => Icons.music_note_outlined,
        TabDestination.parades => Icons.flag_outlined,
        TabDestination.schools => Icons.school_outlined
      };
}
