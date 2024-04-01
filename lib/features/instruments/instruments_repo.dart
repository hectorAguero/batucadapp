import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/core/client_network_provider.dart';
import 'package:samba_public_app/features/instruments/details/instrument_details_page.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';

part 'instruments_repo.g.dart';

@riverpod
InstrumentsRepo instrumentsRepo(InstrumentsRepoRef ref) {
  return InstrumentRepoImpls(ref);
}

abstract class InstrumentsRepo {
  Future<List<Instrument>> getInstruments();

  Future<Instrument> getDetails(InstrumentId id);
}

class InstrumentRepoImpls implements InstrumentsRepo {
  InstrumentRepoImpls(this.ref);

  final InstrumentsRepoRef ref;

  @override
  Future<List<Instrument>> getInstruments() async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<List<dynamic>>('/instruments');
    final data = response.data!.cast<Map<String, dynamic>>();
    return [
      for (final item in data) Instrument.fromMap(item),
    ];
  }

  @override
  Future<Instrument> getDetails(InstrumentId id) async {
    final response = await ref
        .watch(clientNetworkProvider)
        .get<Map<String, dynamic>>('/schools/$id');
    return Instrument.fromMap(response.data!);
  }
}
