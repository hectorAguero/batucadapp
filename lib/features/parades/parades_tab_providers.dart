import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/immutable_list.dart';
import '../../utils/main_logger.dart';
import 'parade.dart';
import 'parades_repo.dart';

part 'parades_tab_providers.g.dart';

@riverpod
class Parades extends _$Parades {
  static const _pageSize = 10;

  @override
  FutureOr<ImmutableList<Parade>> build() async {
    return getParades();
  }

  Future<bool?> fetchNextPage({int pageSize = _pageSize}) async {
    try {
      final parades = await getParades(
        page: state.value!.length ~/ pageSize + 1,
        pageSize: pageSize,
      );
      if (parades.isNotEmpty) {
        state = AsyncData(ImmutableList([...state.value!, ...parades]));
        return true;
      }
      ref.read(paradesTabReachedLimitProvider.notifier).setReachedLimit();
      return false;
    } catch (e, st) {
      logViews.warning('Failed to fetch next page $e', e, st);
      return null;
    }
  }

  Future<ImmutableList<Parade>> getParades({
    int page = 1,
    int pageSize = _pageSize,
  }) async {
    final parades = await ref.watch(paradesRepoProvider).getParades(
          queryParams: ParadeQueryParams(
            page: page,
            pageSize: pageSize,
          ),
        );
    if (parades.isEmpty || parades.length < pageSize) {
      ref.read(paradesTabReachedLimitProvider.notifier).setReachedLimit();
      return parades;
    }
    return parades;
  }
}

@riverpod
class ParadesTabReachedLimit extends _$ParadesTabReachedLimit {
  @override
  bool build() => false;

  void setReachedLimit() {
    state = true;
  }
}

final currentParadeProvider = Provider<Parade>((ref) {
  throw UnimplementedError();
});
