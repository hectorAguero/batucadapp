import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../instrument.dart';
import '../instruments_tab_providers.dart';

part 'instrument_details_providers.g.dart';

@riverpod
class InstrumentDetails extends _$InstrumentDetails {
  @override
  Instrument build(int id) {
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
