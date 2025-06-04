import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'distance_state.g.dart';

@riverpod
class DistanceState extends _$DistanceState {
  @override
  int build() {
    return 100;
  }

  // ignore: use_setters_to_change_properties
  void change(int value) {
    state = value;
  }

  void clean() {
    state = 100;
  }
}
