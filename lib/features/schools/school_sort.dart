import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/features/schools/school.dart';

enum SchoolSort {
  name,
  ranking,
  lastPerformance,
  location,
  foundationDate,
  favorite,
}

extension SchoolSortExtension on SchoolSort {
  int sortSwitch(School first, School second) => switch (this) {
        (SchoolSort.name) => first.name.compareTo(second.name),
        (SchoolSort.ranking) => first.id.compareTo(second.id),
        (SchoolSort.lastPerformance) => first.id.compareTo(second.id),
        (SchoolSort.location) => first.id.compareTo(second.id),
        (SchoolSort.foundationDate) =>
          first.foundationDate.compareTo(second.foundationDate),
        (SchoolSort.favorite) => first.isFavorite ? -1 : 1,
      };

  String get fullName => switch (this) {
        (SchoolSort.name) => 'Name'.hardcoded,
        (SchoolSort.ranking) => 'Ranking'.hardcoded,
        (SchoolSort.lastPerformance) => 'Last Performance'.hardcoded,
        (SchoolSort.location) => 'Location'.hardcoded,
        (SchoolSort.foundationDate) => 'Foundation Date'.hardcoded,
        (SchoolSort.favorite) => 'Favorite'.hardcoded,
      };
}
