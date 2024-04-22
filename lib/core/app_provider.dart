// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_provider.g.dart';

@Riverpod(keepAlive: true)
class AppParent extends _$AppParent {
  @override
  FutureOr<AppModel> build() {
    return const AppModel('AppParent');
  }
}

@Riverpod(keepAlive: true)
class App extends _$App {
  @override
  FutureOr<AppModel> build() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final value = await ref.watch(appParentProvider.future);
    return AppModel(value.name);
  }
}

@immutable
class AppModel {
  const AppModel(this.name);
  final String name;

  @override
  bool operator ==(covariant AppModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
