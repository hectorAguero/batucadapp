import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_page_controller.dart';

part 'instrument_details_page_controller.g.dart';

@riverpod
class InstrumentDetailsPageController
    extends _$InstrumentDetailsPageController {
  @override
  Instrument build(int id) {
    return ref.watch(instrumentsTabPageControllerProvider).requireValue[id];
  }
}
