// ignore_for_file: avoid_print
import 'package:logging/logging.dart';

final logInitialization = Logger('app-init');
final logViews = Logger('view');
final logColorParse = Logger('log-parser-color');
final logAuth = Logger('auth');
final logNetwork = Logger('network');

/// Send output from the given [loggers],
/// at or above the given [level], to the terminal.
void initLoggers(Level level, Set<Logger> loggers) {
  hierarchicalLoggingEnabled = true;
  if (loggers.isEmpty) {
    // ignore: parameter_assignments
    loggers = {logInitialization, logViews, logColorParse, logAuth};
  }
  for (final logger in loggers) {
    if (!_activeLoggers.contains(logger)) {
      print('Initializing logger: ${logger.name}');
      logger
        ..level = level
        ..onRecord.listen(_printLog);

      _activeLoggers.add(logger);
    } else {
      // The logger is already active. Adjust the log level as desired.
      logger.level = level;
    }
  }
}

bool isLogActive(Logger logger) {
  return _activeLoggers.contains(logger);
}

/// Stop the given [loggers] from sending any output to the terminal.
void deactivateLoggers(Set<Logger> loggers) {
  for (final logger in loggers) {
    if (_activeLoggers.contains(logger)) {
      print('Deactivating logger: ${logger.name}');
      logger.clearListeners();

      _activeLoggers.remove(logger);
    }
  }
}

void _printLog(LogRecord record) {
  print(
    '(${record.time.second}.'
    '${record.time.millisecond.toString().padLeft(3, '0')})'
    ' ${record.loggerName} > ${record.level.name}: ${record.message}',
  );
}

final _activeLoggers = <Logger>{};
