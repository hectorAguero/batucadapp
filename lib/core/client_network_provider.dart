import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/core/get_native_adapter.dart'
    if (dart.library.js_interop) 'get_native_adapter_web.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/localization/language_app_provider.dart';

part 'client_network_provider.g.dart';

const baseUrl = 'https://samba.deno.dev';

@Riverpod(keepAlive: true)
class ClientNetwork extends _$ClientNetwork {
  @override
  Dio build() {
    final language = ref.watch(languageAppProvider).value!.languageCode;
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        queryParameters: {
          'language': language,
        },
      ),
    )..httpClientAdapter = getNativeAdapter();

    return dio;
  }
}
