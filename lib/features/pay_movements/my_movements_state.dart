import 'package:basetime/features/pay_movements/movement.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_movements_state.g.dart';

@riverpod
class MyMovementsState extends _$MyMovementsState {
  @override
  FutureOr<List<Movement>> build() {
    return Movement.getMyMovements();
  }
}
