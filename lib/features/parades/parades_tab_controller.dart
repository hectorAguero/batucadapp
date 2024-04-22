import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/app_loggers.dart';
import '../../utils/immutable_list.dart';
import 'parade.dart';
import 'parades_repo.dart';

part 'parades_tab_controller.g.dart';

@riverpod
class ParadesTabController extends _$ParadesTabController {
  static const _pageSize = 10;

  @override
  FutureOr<ImmutableList<Parade>> build() async {
    final parades = await getParades();

    return parades;
  }

  Future<bool?> fetchNextPage({int pageSize = _pageSize}) async {
    final current = state.value ?? const IList.empty();
    try {
      final parades = await getParades(
        page: current.length ~/ pageSize + 1,
        pageSize: pageSize,
      );
      if (parades.isNotEmpty) {
        state = AsyncData(ImmutableList([...current, ...parades]));

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

@riverpod
class ParadeShowOriginal extends _$ParadeShowOriginal {
  @override
  bool build() => true;

  void toggle() => state = !state;
}
