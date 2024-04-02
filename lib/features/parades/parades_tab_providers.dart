import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/parades/parade.dart';
import 'package:samba_public_app/features/parades/parades_repo.dart';

part 'parades_tab_providers.g.dart';

@riverpod
class Parades extends _$Parades {
  @override
  FutureOr<List<Parade>> build() async {
    final parades = await ref.watch(paradesRepoProvider).getParades();
    return parades;
  }
}

final currentParadeProvider = Provider<Parade>((ref) {
  throw UnimplementedError();
});
