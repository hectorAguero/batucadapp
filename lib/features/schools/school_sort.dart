import 'package:flutter/material.dart';
import '../../extensions/app_localization_extension.dart';
import 'school.dart';

enum SchoolSort {
  // ranking,
  lastPerformance,
  name,
  location,
  foundationDate
}

extension SchoolSortExtension on SchoolSort {
  int sortSwitch(School first, School second) => switch (this) {
        (SchoolSort.name) => first.name.compareTo(second.name),
        // (SchoolSort.ranking) => first.id.compareTo(second.ranking),
        (SchoolSort.lastPerformance) =>
          int.parse('${first.divisionNumber}${first.lastPosition}').compareTo(
            int.parse('${second.divisionNumber}${second.lastPosition}'),
          ),
        (SchoolSort.location) =>
          first.leagueLocation.compareTo(second.leagueLocation),
        (SchoolSort.foundationDate) =>
          first.foundationDate.compareTo(second.foundationDate),
      };

  String fullName(BuildContext context) => switch (this) {
        (SchoolSort.name) => context.loc.schoolSortByName,
        // (SchoolSort.ranking) => context.loc.schoolSortByRanking,
        (SchoolSort.lastPerformance) => context.loc.schoolSortByLastPerformance,
        (SchoolSort.location) => context.loc.schoolSortByLocation,
        (SchoolSort.foundationDate) => context.loc.schoolFoundationDate,
      };
}
