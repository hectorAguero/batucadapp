import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_page.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';

part 'instruments_repo.g.dart';

@riverpod
InstrumentsRepo instrumentsRepo(InstrumentsRepoRef ref) {
  return MockInstrumentRepo();
}

abstract class InstrumentsRepo {
  Future<List<Instrument>> getInstruments();

  Future<Instrument> getDetails(InstrumentId id);
}

class MockInstrumentRepo implements InstrumentsRepo {
  @override
  Future<List<Instrument>> getInstruments() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List.generate(
      10,
      (index) => Instrument(
        id: index,
        name: 'Guitar $index strings',
        description: '''
This is a guitar with $index strings,it is a very good guitar for beginners''',
        imageUrl: 'https://source.unsplash.com/random/?instrument',
      ),
    );
  }

  @override
  Future<Instrument> getDetails(InstrumentId id) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return Instrument(
      id: id,
      name: 'Guitar $id strings',
      description: '''
This is a guitar with $id strings,it is a very good guitar for beginners''',
      imageUrl: 'https://source.unsplash.com/random/?instrument',
      details: '''
      This type of guitar should be used by beginners in the process of learning
      so they can get used to the strings and the sound of the guitar.
      ''',
    );
  }
}
