import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/providers/client_network.dart';
import '../../utils/immutable_list.dart';
import 'school.dart';

part 'schools_repo.g.dart';

@riverpod
SchoolsRepo schoolsRepo(SchoolsRepoRef ref) {
  return SchoolsRepoImpls(ref);
}

abstract class SchoolsRepo {
  Future<ImmutableList<School>> getSchools({
    required int page,
    required int pageSize,
    required String sort,
    required String search,
  });
}

class SchoolsRepoImpls implements SchoolsRepo {
  final SchoolsRepoRef ref;

  SchoolsRepoImpls(this.ref);

  @override
  Future<ImmutableList<School>> getSchools({
    required int page,
    required int pageSize,
    required String sort,
    required String search,
  }) async {
    try {
      final networkClient = await ref.watch(clientNetworkProvider.future);
      final response = await networkClient.get<Iterable<dynamic>>(
        search.isEmpty ? Endpoint.schools.path : Endpoint.schools.pathSearch,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (search.isNotEmpty) 'search': search,
          // if (sort.isNotEmpty) 'sort': sort,
        },
      );
      final data = response.data ?? <Map<String, dynamic>>[];

      return ImmutableList([
        for (final item in data.cast<Map<String, dynamic>>())
          School.fromMap(item),
      ]);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }
}
