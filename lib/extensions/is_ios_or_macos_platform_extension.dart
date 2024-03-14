import 'package:flutter/foundation.dart';

bool get kIsCupertino =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.macOS;
