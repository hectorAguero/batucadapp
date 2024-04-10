import 'dart:collection'; // for UnmodifiableListView
import 'package:dart_mappable/dart_mappable.dart';

class UnmodifiableListViewMapper
    extends SimpleMapper1<UnmodifiableListView<dynamic>> {
  @override
  UnmodifiableListView<T> decode<T>(dynamic value) {
    return UnmodifiableListView<T>(
      (value as Iterable).map((e) => MapperContainer.globals.fromValue<T>(e)),
    );
  }

  @override
  dynamic encode<T>(UnmodifiableListView<T> self) {
    return self
        .map((item) => MapperContainer.globals.toValue<T>(item))
        .toList();
  }

  @override
  // ignore: avoid_dynamic_calls
  Function get typeFactory => <T>(Function f) => f<UnmodifiableListView<T>>();
}
