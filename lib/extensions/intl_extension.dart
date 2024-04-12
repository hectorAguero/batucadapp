import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'app_localization_extension.dart';

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

  String intlShortDateTime(BuildContext context, {bool noYear = false}) {
    if (noYear) {
      return DateFormat.MMMEd(
        Localizations.localeOf(context).languageCode,
      ).add_Hm().format(this);
    }
    return DateFormat.yMMMd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(this);
  }
}

extension OrdinalExtension on int {
  String intlOrdinal(BuildContext context) {
    if (context.loc.localeName == 'en') {
      return switch (this % 10) {
        1 => '${this}st',
        2 => '${this}nd',
        3 => '${this}rd',
        _ => '${this}th'
      };
    }
    if (context.loc.localeName == 'ja') {
      return '第$formatNumberToJapanese';
      //return '第$this';
    }
    if (context.loc.localeName == 'es' || context.loc.localeName == 'pt') {
      return '$thisº';
    }
    return '$this';
  }

  String get formatNumberToJapanese {
    // Convert the number to a string
    final numberString = toString();

    // Map each Arabic numeral to its full-width Japanese counterpart
    const fullWidthDigits = {
      '0': '\uFF10', // ０
      '1': '\uFF11', // １
      '2': '\uFF12', // ２
      '3': '\uFF13', // ３
      '4': '\uFF14', // ４
      '5': '\uFF15', // ５
      '6': '\uFF16', // ６
      '7': '\uFF17', // ７
      '8': '\uFF18', // ８
      '9': '\uFF19', // ９
    };

    // Use a regex to replace each digit with its full-width counterpart
    final fullWidthString = numberString.replaceAllMapped(
      RegExp(r'\d'),
      (match) => fullWidthDigits[match.group(0)] ?? '',
    );

    return fullWidthString;
  }
}
