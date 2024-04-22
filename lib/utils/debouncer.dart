import 'dart:async';

import '../constants.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;
  bool _isFirstCall = true;

  /// Debouncer constructor with default delay of 300 milliseconds
  Debouncer([this.delay = Constants.debouncerDelay]);

  void run(void Function() action) {
    if (_isFirstCall) {
      action.call();
      _isFirstCall = false;
      _timer = Timer(delay, () {
        _isFirstCall = true;
      });
    } else {
      _timer?.cancel();
      _timer = Timer(delay, action);
    }
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
