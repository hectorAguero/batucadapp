import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectedHomeTabIndex extends _$SelectedHomeTabIndex {
  @override
  int build() {
    return 0;
  }

  void select(int index) {
    state = index;
  }
}
