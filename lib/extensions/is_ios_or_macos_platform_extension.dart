import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool get kIsCupertino =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.macOS;
