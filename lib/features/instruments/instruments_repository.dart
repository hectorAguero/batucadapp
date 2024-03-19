import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';

part 'instruments_repository.g.dart';

@riverpod
InstrumentsRepository instrumentsRepository(InstrumentsRepositoryRef ref) {
  return MockInstrumentRepository();
}

abstract class InstrumentsRepository {
  Future<List<Instrument>> getInstruments();
}

class MockInstrumentRepository implements InstrumentsRepository {
  @override
  Future<List<Instrument>> getInstruments() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List.generate(
      10,
      (index) => Instrument(
        id: index,
        name: 'Guitar $index strings',
        description:
            'This is a guitar with $index strings, it is a very good guitar for beginners',
        imageUrl: 'https://source.unsplash.com/random/?instrument',
      ),
    );
  }
}
