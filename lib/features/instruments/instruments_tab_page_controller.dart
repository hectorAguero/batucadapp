import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/instruments_repository.dart';

part 'instruments_tab_page_controller.g.dart';

@riverpod
class InstrumentsTabPageController extends _$InstrumentsTabPageController {
  @override
  FutureOr<List<Instrument>> build() async {
    return await ref.watch(instrumentsRepositoryProvider).getInstruments();
  }
}
