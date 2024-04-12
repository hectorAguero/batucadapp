import 'package:native_dio_adapter/native_dio_adapter.dart';

const _maxCacheSize = 2 * 1024 * 1024; // 2MB

NativeAdapter getNativeAdapter({required bool cronetHttp2}) {
  return NativeAdapter(
    createCupertinoConfiguration: () {
      final config = URLSessionConfiguration.ephemeralSessionConfiguration()
        ..cache = URLCache.withCapacity(
          memoryCapacity: _maxCacheSize,
        );
      return config;
    },
    createCronetEngine: () {
      return CronetEngine.build(
        cacheMode: CacheMode.memory,
        enableBrotli: true,
        enableHttp2: true,
        enableQuic: true,
        cacheMaxSize: _maxCacheSize,
      );
    },
  );
}
