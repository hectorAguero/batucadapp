import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_page.dart';
import 'package:samba_public_app/features/parades/parades_tab.dart';
import 'package:samba_public_app/features/schools/schools_tab.dart';

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
        TabDestination.schools => SchoolsTab.route.path,
      };

  String get label => switch (this) {
        TabDestination.instruments => 'Instruments',
        TabDestination.parades => 'Parades',
        TabDestination.schools => 'Schools'
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
