import 'package:native_dio_adapter/native_dio_adapter.dart';

const _maxCacheSize = 2 * 1024 * 1024; // 2MB

NativeAdapter getNativeAdapter() {
  return NativeAdapter(
    createCupertinoConfiguration: () {
      final config = URLSessionConfiguration.ephemeralSessionConfiguration()
        ..cache = URLCache.withCapacity(memoryCapacity: _maxCacheSize);
      return config;
    },
    createCronetEngine: () {
      return CronetEngine.build(
        cacheMode: CacheMode.memory,
        cacheMaxSize: _maxCacheSize,
      );
    },
  );
}
