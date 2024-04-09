import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/client_network_provider.dart';
import '../../utils/unmodifiable_list.dart';
import 'parade.dart';

part 'parades_repo.g.dart';

@riverpod
ParadesRepo paradesRepo(ParadesRepoRef ref) {
  return ParadesRepoImpl(ref);
}

abstract class ParadesRepo {
  Future<UnmodifiableList<Parade>> getParades();

  Future<Parade> getParade(int id);
}

class ParadesRepoImpl implements ParadesRepo {
  ParadesRepoImpl(this.ref);

  final ParadesRepoRef ref;

  @override
  Future<UnmodifiableList<Parade>> getParades({
    ParadeQueryParams? queryParams,
  }) async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<Iterable<dynamic>>('/parades');
    final data = response.data!.cast<Map<String, dynamic>>();
    return UnmodifiableList([
      for (final item in data) Parade.fromMap(item),
    ]);
  }

  @override
  Future<Parade> getParade(int id, {ParadeQueryParams? queryParams}) async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<Map<String, dynamic>>('/parades/$id');
    return Parade.fromMap(response.data!);
  }
}
