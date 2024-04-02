import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';

extension IntlExtension on DateTime {
  String intlShort(BuildContext context) {
    return DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).format(this);
  }

  String intlLong(BuildContext context) {
    return DateFormat.yMMMMd(
      Localizations.localeOf(context).languageCode,
    ).format(this);
  }

  String intlTime(BuildContext context) {
    return DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(this);
  }

  String intlShortDateTime(BuildContext context) {
    return DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(this);
  }
}

extension OrdinalExtension on int {
  String ordinal(BuildContext context) {
    if (context.loc.localeName == 'en') {
      return switch (this % 10) {
        1 => '${this}st',
        2 => '${this}nd',
        3 => '${this}rd',
        _ => '${this}th'
      };
    }
    if (context.loc.localeName == 'ja') {
      return '第$this';
    }
    if (context.loc.localeName == 'es' || context.loc.localeName == 'pt') {
      return '$thisº';
    }
    return '$this';
  }
}
