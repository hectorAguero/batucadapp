import 'package:batucadapp/features/schools/school.dart';
import 'package:batucadapp/features/schools/schools_repo.dart';
import 'package:batucadapp/utils/immutable_list.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils.dart';

class SchoolsRepoMock with Mock implements SchoolsRepoImpls {}

void main() {
  group('Schools Repository', () {
    test(
      '''
          When SchoolsRepo is called
          Should return a instance of SchoolsRepoImpls
          ''',
      () {
        final mock = SchoolsRepoMock();
        final container = createContainer(
          overrides: [schoolsRepoProvider.overrideWith((_) => mock)],
        );

        expect(
          container.read(schoolsRepoProvider),
          isA<SchoolsRepoImpls>(),
        );
      },
    );

    test('''
         When SchoolsRepo.getSchools is called
         Should return a list of Schools
         ''', () async {
      const page = 1;
      const pageSize = 10;
      final mock = SchoolsRepoMock();
      when(
        () => mock.getSchools(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          sort: any(named: 'sort'),
          search: any(named: 'search'),
        ),
      ).thenAnswer((_) async => <School>[].lock);

      final container = createContainer(
        overrides: [schoolsRepoProvider.overrideWith((_) => mock)],
      );

      expect(
        await container.read(schoolsRepoProvider).getSchools(
              page: page,
              pageSize: pageSize,
              sort: 'name',
              search: '',
            ),
        isA<ImmutableList<School>>(),
      );
    });

    test('''
         When SchoolsRepo.getSchools is called
         Should throw an error
         ''', () async {
      const page = 1;
      const pageSize = 10;
      final mock = SchoolsRepoMock();
      when(
        () => mock.getSchools(
          page: any(named: 'page'),
          pageSize: any(named: 'pageSize'),
          sort: any(named: 'sort'),
          search: any(named: 'search'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      final container = createContainer(
        overrides: [schoolsRepoProvider.overrideWith((_) => mock)],
      );

      expect(
        () => container.read(schoolsRepoProvider).getSchools(
              page: page,
              pageSize: pageSize,
              sort: 'name',
              search: '',
            ),
        throwsA(isA<DioException>()),
      );
    });
  });
}
