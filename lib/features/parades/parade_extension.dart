import 'parade.dart';

extension ParadeExtension on Parade {
  String get getPlacingIcon => switch (placing) {
        1 => '🏆',
        2 => '🥈',
        3 => '🥉',
        _ => '🏅',
      };
}
