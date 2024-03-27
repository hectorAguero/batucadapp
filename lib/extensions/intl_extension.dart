import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension IntlExtension on DateTime {
  String intlShort(BuildContext context) {
    return DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).format(this);
  }
}
