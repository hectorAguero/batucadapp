import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../extensions/app_localization_extension.dart';
import '../instruments/instruments_tab_page.dart';
import '../parades/parades_tab_page.dart';
import '../schools/schools_tab_page.dart';

part 'home_page_controller.g.dart';

@Riverpod(keepAlive: true)
class CurrentTab extends _$CurrentTab {
  @override

  ///Change for a pattern or record of hometab and boolean is is top
  // HomeTab build() => HomeTab.instruments;
  ({HomeTab tab, bool topRoute}) build() =>
      (tab: HomeTab.instruments, topRoute: false);

  void set(HomeTab tab, {bool top = false}) =>
      state = (tab: tab, topRoute: top);
}

enum HomeTab { instruments, parades, schools }

extension HomeTabExtension on HomeTab {
  String get path => switch (this) {
        HomeTab.instruments => InstrumentsTabPage.path,
        HomeTab.parades => ParadesTabPage.path,
        HomeTab.schools => SchoolsTabPage.path,
      };

  String label(BuildContext context) => switch (this) {
        HomeTab.instruments => context.loc.instrumentsTitle,
        HomeTab.parades => context.loc.paradesTitle,
        HomeTab.schools => context.loc.schoolsTitle
      };

  IconData get icon => switch (this) {
        HomeTab.instruments => Icons.music_note,
        HomeTab.parades => Icons.flag,
        HomeTab.schools => Icons.school
      };

  IconData get selectedIcon => switch (this) {
        HomeTab.instruments => Icons.music_note_outlined,
        HomeTab.parades => Icons.flag_outlined,
        HomeTab.schools => Icons.school_outlined
      };
}
