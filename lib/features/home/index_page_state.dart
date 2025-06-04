import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index_page_state.g.dart';

@riverpod
class IndexPage extends _$IndexPage {
  @override
  int build() {
    return 2;
  }

  // ignore: use_setters_to_change_properties
  void setIndex(int index) {
    state = index;
  }
}
