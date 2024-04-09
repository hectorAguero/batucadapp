import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/unmodifiable_list.dart';
import 'parade.dart';
import 'parades_repo.dart';

part 'parades_tab_providers.g.dart';

@riverpod
class Parades extends _$Parades {
  @override
  FutureOr<UnmodifiableList<Parade>> build() async {
    final parades = await ref.watch(paradesRepoProvider).getParades();
    return parades;
  }
}

final currentParadeProvider = Provider<Parade>((ref) {
  throw UnimplementedError();
});
