import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../instrument.dart';
import '../instruments_tab_controller.dart';

part 'instrument_details_controller.g.dart';

@riverpod
class InstrumentDetailsController extends _$InstrumentDetailsController {
  @override
  Instrument build(int id) {
    final instrument = ref
        .watch(instrumentsTabControllerProvider)
        .value
        ?.firstWhere((element) => element.id == id);
    if (instrument == null) {
      throw Exception('Instrument not found');
    }

    return instrument;
  }
}
