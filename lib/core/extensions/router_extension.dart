import 'package:go_router/go_router.dart';

extension RouterExtension on GoRoute {
  String addPathParameters(Map<String, String> parameters) {
    var newPath = path;
    for (final entry in parameters.entries) {
      newPath = newPath.replaceAll(':${entry.key}', entry.value);
    }

    return newPath;
  }
}
