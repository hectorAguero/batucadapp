// app_localizations_context.dart
import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
