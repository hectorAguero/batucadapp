import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/app_error_handler.dart';
import '../../utils/app_loggers.dart';
import '../../utils/immutable_list.dart';
import 'prefs.dart';

part 'initialization.g.dart';

@Riverpod(keepAlive: true)
Future<void> initialization(InitializationRef ref) async {
  registerErrorHandlers();
  initializeFICMappers();
  if (kDebugMode) initLoggers(Level.FINE, {});
  ref.onDispose(() {
    ref.invalidate(prefsProvider);
  });
  await ref.watch(prefsProvider.future);
}
