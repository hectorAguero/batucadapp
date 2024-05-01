import 'package:batucadapp/features/instruments/instrument.dart';
import 'package:batucadapp/features/instruments/instruments_repo.dart';
import 'package:batucadapp/utils/immutable_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../create_container.dart';

class InstrumentsRepoMock with Mock implements InstrumentsRepoImpls {}

void main() {
  group('Instruments Repository', () {
    test(
      '''
          When InstrumentsRepo is called
          Should return a instance of InstrumentsRepoImpls
          ''',
      () {
        final mock = InstrumentsRepoMock();
        final container = createContainer(
          overrides: [instrumentsRepoProvider.overrideWith((_) => mock)],
        );

        expect(
          container.read(instrumentsRepoProvider),
          isA<InstrumentsRepoImpls>(),
        );
      },
    );

    test(
      '''
            When getInstruments is called
            Should return a immutable list of instruments
        ''',
      () {
        final mock = InstrumentsRepoMock();
        when(mock.getInstruments).thenAnswer(
          (_) async => ImmutableList(const <Instrument>[]),
        );
        final container = createContainer(
          overrides: [instrumentsRepoProvider.overrideWith((_) => mock)],
        );

        expectLater(
          container.read(instrumentsRepoProvider).getInstruments(),
          completion(isA<ImmutableList<Instrument>>()),
        );
        verify(mock.getInstruments).called(1);
      },
    );

    test(
      '''
          When getInstruments is called
          Should return a immutable list of instruments
      ''',
      () async {
        final mock = InstrumentsRepoMock();
        when(mock.getInstruments).thenThrow(
          Exception("Error"),
        );
        final container = createContainer(
          overrides: [instrumentsRepoProvider.overrideWith((_) => mock)],
        );

        await expectLater(
          () => container.read(instrumentsRepoProvider).getInstruments(),
          throwsA(isA<Exception>()),
        );
        verify(mock.getInstruments).called(1);
      },
    );
  });
}
