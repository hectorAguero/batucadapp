import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_providers.dart';

part 'instrument_details_providers.g.dart';

@riverpod
class InstrumentDetails extends _$InstrumentDetails {
  @override
  FutureOr<Instrument> build(int id) async {
    final instrument = ref
        .watch(instrumentsTabProvider)
        .value
        ?.firstWhere((element) => element.id == id);
    if (instrument == null) {
      throw Exception('Instrument not found');
    }
    return instrument;
  }
}
