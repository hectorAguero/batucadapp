import 'package:flutter/foundation.dart';

void debugLog(String? message, {int? wrapWidth}) {
  if (kDebugMode) {
    debugPrint(message, wrapWidth: wrapWidth);
  }
}
