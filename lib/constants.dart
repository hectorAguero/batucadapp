final class Constants {
  // Other type of constants are in the .env file
  // Network
  static const connectTimeout = Duration(seconds: 2);
  static const receiveTimeout = Duration(seconds: 3);

  /// Duration(milliseconds: 300)
  static const debouncerDelay = Duration(milliseconds: 300);

  static const defaultColorName = 'Default';

  Constants._();
}
