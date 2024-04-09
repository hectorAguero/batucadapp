import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/client_network_provider.dart';
import '../../utils/unmodifiable_list.dart';
import 'school.dart';

part 'schools_repo.g.dart';

@riverpod
SchoolsRepo schoolsRepo(SchoolsRepoRef ref) {
  return SchoolsRepoImpls(ref);
}

abstract class SchoolsRepo {
  Future<UnmodifiableList<School>> getSchools();
}

class SchoolsRepoImpls implements SchoolsRepo {
  SchoolsRepoImpls(this.ref);

  final SchoolsRepoRef ref;

  @override
  Future<UnmodifiableList<School>> getSchools() async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<Iterable<dynamic>>('/schools');
    final data = response.data!.cast<Map<String, dynamic>>();
    return UnmodifiableList([
      for (final item in data) School.fromMap(item),
    ]);
  }
}

class MockSchoolsRepo implements SchoolsRepo {
  MockSchoolsRepo(this.ref);

  final SchoolsRepoRef ref;

  @override
  Future<UnmodifiableList<School>> getSchools() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return UnmodifiableList([
      SchoolMapper.fromMap(
        {
          'id': 3,
          'name': 'Unidos de Vila Isabel',
          'image_url':
              'https://samba.deno.dev/static/images/schools/unidos_de_vila_isabel.jpg',
          'foundation_date': '1946/4/4',
          'godmother_school': 'Portela',
          'colors': ['Blanco', 'Azul'],
          'symbols': ['Corona', 'Clave de Sol', 'Pandereta', 'Pluma'],
          'league': 'LIESA',
          'current_division': 'Grupo Especial',
          'division_number': 1,
        },
      ),
      SchoolMapper.fromMap({
        'id': 4,
        'name': 'Beija-Flor de Nilópolis',
        'image_url':
            'https://samba.deno.dev/static/images/schools/beija_flor_de_nipolis.jpg',
        'foundation_date': '1948/12/25',
        'godmother_school': 'Portela',
        'colors': [
          'Azul',
          'Blanco',
        ],
        'symbols': [
          'Colibrí',
        ],
        'league': 'LIESA',
        'current_division': 'Grupo Especial',
        'division_number': 1,
      }),
      SchoolMapper.fromMap({
        'id': 6,
        'name': 'Acadêmicos do Grande Rio',
        'image_url':
            'https://samba.deno.dev/static/images/schools/academicos_do_grande_rio.jpg',
        'foundation_date': '1988/9/22',
        'godmother_school': 'Salgueiro',
        'colors': [
          'Verde',
          'Blanco',
          'Rojo',
        ],
        'symbols': [
          'Corona',
        ],
        'league': 'LIESA',
        'current_division': 'Grupo Especial',
        'division_number': 1,
      }),
      SchoolMapper.fromMap({
        'id': 7,
        'name': 'Acadêmicos do Salgueiro',
        'image_url':
            'https://samba.deno.dev/static/images/schools/academicos_do_salgueiro.jpg',
        'foundation_date': '1953/3/5',
        'godmother_school': 'Mangueira',
        'colors': [
          'Rojo',
          'Blanco',
        ],
        'symbols': [
          'Pandereta',
          'Surdo de barril',
          'Tamborim cuadrado',
          'Afoxé de calabaza',
          'Baqueta',
        ],
        'league': 'LIESA',
        'current_division': 'Grupo Especial',
        'division_number': 1,
      }),
      SchoolMapper.fromMap({
        'id': 19,
        'name': 'São Clemente',
        'image_url':
            'https://samba.deno.dev/static/images/schools/sao_clemente.jpg',
        'foundation_date': '1961/10/25',
        'godmother_school': 'Unidos de Vila Isabel',
        'colors': [
          'Negro',
          'Amarillo',
        ],
        'symbols': [
          'Pandereta',
          'Ensenada de Botafogo',
          'Pan de Azúcar',
        ],
        'league': 'LIERJ',
        'current_division': 'Serie Oro',
        'division_number': 2,
      }),
    ]);
  }
}
