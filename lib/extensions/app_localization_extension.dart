// app_localizations_context.dart
import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
