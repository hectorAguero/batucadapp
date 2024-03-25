import 'package:intl/intl.dart';

final _defaultLocale = Intl.defaultLocale;

extension IntlExtension on DateTime {
  String get intl => DateFormat(_defaultLocale).format(this);

  String get intlShort => intl.split(' ').take(3).join(' ');
}
