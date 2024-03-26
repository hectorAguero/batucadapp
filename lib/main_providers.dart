import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/localization/language_app_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) =>
    SharedPreferences.getInstance();

const baseUrl = 'https://samba.deno.dev';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final language = ref.watch(languageAppProvider).value?.languageCode;
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      queryParameters: {
        'language': language,
      },
    ),
  );
  return dio;
}
