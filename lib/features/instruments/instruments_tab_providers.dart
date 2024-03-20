import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/instruments_repo.dart';

part 'instruments_tab_providers.g.dart';

@riverpod
class InstrumentsTab extends _$InstrumentsTab {
  @override
  FutureOr<List<Instrument>> build() async {
    return await ref.watch(instrumentsRepoProvider).getInstruments();
  }

  void updateInstrument(Instrument instrument) {
    state = AsyncData([
      for (final i in state.requireValue)
        if (i.id == instrument.id) instrument else i,
    ]);
  }
}
