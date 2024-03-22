import 'package:logger/logger.dart';

/// A measure to avoid using print like this because there is no linter
/// if (kDebugMode) {
///   debugPrint('A useful message');
/// }
///
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static Logger get logger => _logger;
}
