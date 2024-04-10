import 'dart:async';

class Debouncer {
  Debouncer({required this.delay});
  final Duration delay;
  Timer? _timer;
  bool _isFirstCall = true;

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
