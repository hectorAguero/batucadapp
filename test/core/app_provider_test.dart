// ignore_for_file: invalid_use_of_visible_for_overriding_member

import 'package:batucadapp/core/app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppParent extends AsyncNotifier<AppModel>
    with Mock
    implements AppParent {}

class MockApp extends AsyncNotifier<AppModel> with Mock implements App {}

void main() {
  test('Provider return the desired string', () async {
    final mockAppParent = MockAppParent();

    when(mockAppParent.build).thenReturn(const AppModel('AppParent'));

    final container = createContainer(
      overrides: [
        appParentProvider.overrideWith(() => mockAppParent),
        appProvider.overrideWith(App.new),
      ],
    );
    final provider = await container.read(appProvider.future);
    expect(provider.name, 'AppParent');
  });
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}
