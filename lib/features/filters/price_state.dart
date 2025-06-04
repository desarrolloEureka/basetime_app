import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_state.g.dart';

@riverpod
class PriceRange extends _$PriceRange {
  @override
  RangeValues build() {
    return const RangeValues(0, 1);
  }

  // ignore: use_setters_to_change_properties
  void change(RangeValues values) {
    state = values;
  }

  void clean() {
    state = const RangeValues(0, 1);
  }
}
