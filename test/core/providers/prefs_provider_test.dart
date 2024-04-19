import 'package:batucadapp/core/providers/prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  ProviderContainer makeProviderContainer(MockSharedPreferences prefs) {
    final container = ProviderContainer(
      overrides: [prefsProvider.overrideWith((_) => prefs)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('Should return a SharedPreferences instance', () async {
    final prefs = MockSharedPreferences();
    final container = makeProviderContainer(prefs);
    await expectLater(
      container.read(prefsProvider.future),
      completion(prefs),
    );
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {
  //setMockInitialValues
  static MockSharedPreferences setMockInitialValues(
    Map<String, dynamic> values,
  ) {
    final mock = MockSharedPreferences();
    when(mock.getKeys).thenReturn(values.keys.toSet());
    for (final entry in values.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value is bool) {
        when(() => mock.getBool(key)).thenReturn(value);
      } else if (value is num) {
        if (value is int) {
          when(() => mock.getInt(key)).thenReturn(value);
        } else if (value is double) {
          when(() => mock.getDouble(key)).thenReturn(value);
        }
      } else if (value is String) {
        when(() => mock.getString(key)).thenReturn(value);
      } else if (value is List<String>) {
        when(() => mock.getStringList(key)).thenReturn(value);
      } else {
        throw UnimplementedError('Type ${value.runtimeType} not implemented');
      }
    }
    return mock;
  }
}
