import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/providers/client_network_provider.dart';
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
  SchoolsRepoImpls(this.ref);

  final SchoolsRepoRef ref;

  @override
  Future<ImmutableList<School>> getSchools({
    required int page,
    required int pageSize,
    required String sort,
    required String search,
  }) async {
    try {
      final networkClient = ref.watch(clientNetworkProvider).requireValue;
      final response = await networkClient.get<Iterable<dynamic>>(
        search.isEmpty ? Endpoint.schools.path : Endpoint.schools.pathSearch,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (search.isNotEmpty) 'search': search,
          // if (sort.isNotEmpty) 'sort': sort,
        },
      );
      final data = response.data!.cast<Map<String, dynamic>>();
      return ImmutableList([
        for (final item in data) School.fromMap(item),
      ]);
    } catch (e) {
      throw AppNetworkError.fromNetworkClientException(e);
    }
  }
}
