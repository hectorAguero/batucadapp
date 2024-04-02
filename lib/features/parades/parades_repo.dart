import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/core/client_network_provider.dart';
import 'package:samba_public_app/features/parades/parade.dart';

part 'parades_repo.g.dart';

@riverpod
ParadesRepo paradesRepo(ParadesRepoRef ref) {
  return ParadesRepoImpl(ref);
}

abstract class ParadesRepo {
  Future<List<Parade>> getParades();

  Future<Parade> getParade(int id);
}

class ParadesRepoImpl implements ParadesRepo {
  ParadesRepoImpl(this.ref);

  final ParadesRepoRef ref;

  @override
  Future<List<Parade>> getParades({ParadeQueryParams? queryParams}) async {
    final response =
        await ref.watch(clientNetworkProvider).get<List<dynamic>>('/parades');

    final data = response.data!.cast<Map<String, dynamic>>();
    return [
      for (final item in data) Parade.fromMap(item),
    ];
  }

  @override
  Future<Parade> getParade(int id, {ParadeQueryParams? queryParams}) async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<Map<String, dynamic>>('/parades/$id');
    return Parade.fromMap(response.data!);
  }
}
