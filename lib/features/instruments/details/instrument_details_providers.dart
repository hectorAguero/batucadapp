import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samba_public_app/features/instruments/instrument.dart';
import 'package:samba_public_app/features/instruments/instruments_repo.dart';
import 'package:samba_public_app/features/instruments/instruments_tab_providers.dart';

part 'instrument_details_providers.g.dart';

@riverpod
class InstrumentDetails extends _$InstrumentDetails {
  @override
  FutureOr<Instrument> build(int id) async {
    final details = await ref.watch(instrumentsRepoProvider).getDetails(id);
    ref.watch(instrumentsTabProvider.notifier).updateInstrument(details);

    return details;
  }
}
