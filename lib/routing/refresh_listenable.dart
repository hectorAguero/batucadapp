import 'dart:async';

import 'package:flutter/foundation.dart';

/// This class was imported from the migration guide for GoRouter 5.0
class RefreshListenable extends ChangeNotifier {
  // ignore: avoid_late_keyword
  late final StreamSubscription<dynamic> _subscription;

  RefreshListenable(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
