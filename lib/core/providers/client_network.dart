import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants.dart';
import '../../localization/language.dart';
import '../../localization/language_app_controller.dart';
import '../../utils/app_loggers.dart';
import 'client_network/network_client_adapter.dart'
    if (dart.library.js_interop) 'client_network/network_client_adapter_web.dart';

part 'client_network.g.dart';

@Riverpod(keepAlive: true)
class ClientNetwork extends _$ClientNetwork {
  @override
  FutureOr<Dio> build() async {
    final cacheDirPath = await _getTemporaryDirectory();
    final futureLanguage =
        await ref.watch(languageAppControllerProvider.future);
    final language = futureLanguage.languageCode;
    final cache = CacheOptions(
      store: BackupCacheStore(
        primary: MemCacheStore(),
        secondary: HiveCacheStore(cacheDirPath),
      ),
      hitCacheOnErrorExcept: [],
    );
    final options = BaseOptions(
      baseUrl: Endpoint.basePath.path,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
      queryParameters: {'language': language},
    );
    final dio = Dio(options)
      ..httpClientAdapter = getNativeAdapter()
      ..interceptors.add(DioCacheInterceptor(options: cache))
      ..interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          request: false,
          logPrint: logNetwork.info,
        ),
      );

    ref.onDispose(
      () {
        logNetwork.info('Closing dio');
        dio.close();
      },
    );

    return dio;
  }

  Future<String?> _getTemporaryDirectory() async {
    try {
      final dir = await getTemporaryDirectory();

      return dir.path;
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
        basePath => dotenv.env['API_URL']!,
        parades => '/parades',
        instruments => '/instruments',
        schools => '/schools',
      };
}

class AppNetworkError extends Error {
  final String message;

  AppNetworkError(this.message);

  AppNetworkError.fromNetworkClientException(Object e)
      : message = messageFromDio(e);

  @override
  String toString() => message;

  static String messageFromDio(Object e) {
    if (e is! DioException) return 'Unknown error 🤷';

    return switch (e.type) {
      DioExceptionType.badCertificate => 'Bad certificate 📜',
      DioExceptionType.connectionTimeout => 'Connection timeout ⏰',
      DioExceptionType.sendTimeout => 'Send timeout ⏰',
      DioExceptionType.receiveTimeout => 'Receive timeout ⏰',
      DioExceptionType.badResponse => 'Bad response 🤷',
      DioExceptionType.cancel => 'Request cancelled 🚫',
      DioExceptionType.connectionError => 'Connection error 🚫',
      DioExceptionType.unknown => 'No internet connection 🌎',
    };
  }
}
