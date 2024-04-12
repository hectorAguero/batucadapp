import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../localization/language.dart';
import '../localization/language_app_provider.dart';
import '../utils/main_logger.dart';
import 'get_native_adapter.dart'
    if (dart.library.js_interop) 'get_native_adapter_web.dart';

part 'client_network_provider.g.dart';

const _baseUrlPath = 'https://samba.deno.dev';
const _connectTimeout = Duration(seconds: 2);
const _receiveTimeout = Duration(seconds: 3);

@Riverpod(keepAlive: true)
class ClientNetwork extends _$ClientNetwork {
  @override
  Future<Dio> build() async {
    final language = ref.watch(languageAppProvider).value!.languageCode;
    final cacheDirPath = await _getTemporaryDirectory();
    final cacheStore = CacheOptions(
      store: HiveCacheStore(
        cacheDirPath,
      ),
      hitCacheOnErrorExcept: [401, 403],
    );
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoint.basePath.path,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        queryParameters: {
          'language': language,
        },
      ),
    )
      ..httpClientAdapter = getNativeAdapter(crotnetHttp2: true)
      ..interceptors.add(DioCacheInterceptor(options: cacheStore))
      ..interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          request: false,
        ),
      );

    ref.onDispose(dio.close);

    return dio;
  }

  Future<String?> _getTemporaryDirectory() async {
    try {
      return getTemporaryDirectory().then((value) => value.path);
    } catch (e) {
      logNetwork.info('Error getting temporary directory: $e');
      return null;
    }
  }
}

enum Endpoint {
  basePath,
  parades,
  instruments,
  schools;

  String get pathId => '$path/';
  String get pathSearch => '$path/search';
  String get path => switch (this) {
        basePath => _baseUrlPath,
        parades => '/parades',
        instruments => '/instruments',
        schools => '/schools',
      };
}
