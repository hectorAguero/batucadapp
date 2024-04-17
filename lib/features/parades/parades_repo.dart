import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/client_network_provider.dart';
import '../../utils/immutable_list.dart';
import 'parade.dart';

part 'parades_repo.g.dart';

@riverpod
ParadesRepo paradesRepo(ParadesRepoRef ref) {
  return ParadesRepoImpl(ref);
}

abstract class ParadesRepo {
  Future<ImmutableList<Parade>> getParades({
    ParadeQueryParams? queryParams,
  });

  Future<Parade> getParade(int id);
}

class ParadesRepoImpl implements ParadesRepo {
  ParadesRepoImpl(this.ref);

  final ParadesRepoRef ref;

  @override
  Future<ImmutableList<Parade>> getParades({
    ParadeQueryParams? queryParams,
  }) async {
    try {
      final response =
          await ref.watch(clientNetworkProvider).value!.get<Iterable<dynamic>>(
        Endpoint.parades.path,
        queryParameters: {
          if (queryParams?.page != null) 'page': queryParams!.page,
          if (queryParams?.pageSize != null) 'pageSize': queryParams!.pageSize,
        },
      );
      final data = response.data!.cast<Map<String, dynamic>>();
      return ImmutableList([
        for (final item in data) Parade.fromMap(item),
      ]);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }

  @override
  Future<Parade> getParade(int id, {ParadeQueryParams? queryParams}) async {
    try {
      final response = await ref
          .watch(clientNetworkProvider)
          .value!
          .get<Map<String, dynamic>>('${Endpoint.parades.pathId}/$id');
      return Parade.fromMap(response.data!);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }
}
