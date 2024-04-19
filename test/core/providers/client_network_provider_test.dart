import 'dart:ui';

import 'package:batucadapp/constants.dart';
import 'package:batucadapp/core/providers/client_network_provider.dart';
import 'package:batucadapp/localization/language_app_provider.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockClientNetwork extends AsyncNotifier<Dio>
    with Mock
    implements ClientNetwork {}

void main() {
  ProviderContainer makeProviderContainer(
    MockClientNetwork mockClientNetwork,
  ) {
    final container = ProviderContainer(
      overrides: [
        languageAppProvider.overrideWith(LanguageApp.new),
        clientNetworkProvider.overrideWith(() => mockClientNetwork),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('ClientNetwork build', () {
    test('Dio is configured with correct base URL and language', () async {
      final dio = Dio();
      final mock = MockClientNetwork();
      when(mock.build).thenAnswer((_) async => dio);
      final container = makeProviderContainer(mock);

      await expectLater(
        container.read(clientNetworkProvider.future),
        completion(isA<Dio>()),
      );
    });

    test('Dio is configured with correct base URL and language', () async {
      final dio = MockDio()..options.baseUrl = Endpoint.basePath.path;
      final mock = MockClientNetwork();
      when(mock.build).thenAnswer((_) async => dio);
      final container = makeProviderContainer(mock);

      final url = await container.read(clientNetworkProvider.future);

      await expectLater(
        url,
        AppConstants.baseUrlPath,
      );
    });Te
  });
}
