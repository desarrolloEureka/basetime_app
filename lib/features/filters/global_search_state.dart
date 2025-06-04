import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_search_state.g.dart';

@riverpod
class GlobalSearchState extends _$GlobalSearchState {
  @override
  bool build() {
    return false;
  }

  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void change(bool value) {
    state = value;
  }

  void clean() {
    state = true;
  }
}
