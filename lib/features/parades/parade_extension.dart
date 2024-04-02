import 'package:samba_public_app/features/parades/parade.dart';

extension ParadeExtension on Parade {
  String get getPlacingIcon => switch (placing) {
        1 => '🏆',
        2 => '🥈',
        3 => '🥉',
        _ => '🏅',
      };
}
