import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/providers/client_network.dart';
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
  final ParadesRepoRef ref;
  ParadesRepoImpl(this.ref);

  @override
  Future<ImmutableList<Parade>> getParades({
    ParadeQueryParams? queryParams,
  }) async {
    try {
      final dio = await ref.watch(clientNetworkProvider.future);
      final page = queryParams?.page;
      final pageSize = queryParams?.pageSize;
      final response = await dio.get<Iterable<dynamic>>(
        Endpoint.parades.path,
        queryParameters: {
          if (page != null) 'page': page,
          if (pageSize != null) 'pageSize': pageSize,
        },
      );
      final data = response.data ?? <Map<String, dynamic>>[];

      return ImmutableList([
        for (final item in data.cast<Map<String, dynamic>>())
          Parade.fromMap(item),
      ]);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }

  @override
  Future<Parade> getParade(int id, {ParadeQueryParams? queryParams}) async {
    try {
      final dio = await ref.watch(clientNetworkProvider.future);
      final response =
          await dio.get<Map<String, dynamic>>('${Endpoint.parades.pathId}/$id');

      return Parade.fromMap(response.data ?? {});
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }
}
