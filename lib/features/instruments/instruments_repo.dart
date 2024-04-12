import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/client_network_provider.dart';
import '../../utils/unmodifiable_list.dart';
import 'details/instrument_details_page.dart';
import 'instrument.dart';

part 'instruments_repo.g.dart';

@riverpod
InstrumentsRepo instrumentsRepo(InstrumentsRepoRef ref) {
  return InstrumentRepoImpls(ref);
}

abstract class InstrumentsRepo {
  Future<UnmodifiableList<Instrument>> getInstruments();

  Future<Instrument> getDetails(InstrumentId id);
}

class InstrumentRepoImpls implements InstrumentsRepo {
  InstrumentRepoImpls(this.ref);

  final InstrumentsRepoRef ref;

  @override
  Future<UnmodifiableList<Instrument>> getInstruments() async {
    final response = await ref
        .watch(clientNetworkProvider)
        .value!
        .get<Iterable<dynamic>>(Endpoint.instruments.path);
    final data = response.data!.cast<Map<String, dynamic>>();
    return UnmodifiableList([
      for (final item in data) Instrument.fromMap(item),
    ]);
  }

  @override
  Future<Instrument> getDetails(InstrumentId id) async {
    final response =
        await ref.watch(clientNetworkProvider).value!.get<Map<String, dynamic>>(
              '${Endpoint.instruments.pathId}/$id',
            );
    return Instrument.fromMap(response.data!);
  }
}
