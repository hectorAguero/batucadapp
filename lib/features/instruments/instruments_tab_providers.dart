import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/immutable_list.dart';
import 'instrument.dart';
import 'instruments_repo.dart';

part 'instruments_tab_providers.g.dart';

@riverpod
class InstrumentsTab extends _$InstrumentsTab {
  @override
  FutureOr<ImmutableList<Instrument>> build() async {
    return await ref.watch(instrumentsRepoProvider).getInstruments();
  }

  void updateInstrument(Instrument instrument) {
    state = AsyncData(
      ImmutableList([
        for (final i in state.requireValue)
          if (i.id == instrument.id) instrument else i,
      ]),
    );
  }
}
