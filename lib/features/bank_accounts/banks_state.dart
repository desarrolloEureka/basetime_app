import 'package:basetime/features/bank_accounts/bank.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banks_state.g.dart';

@riverpod
class BanksState extends _$BanksState {
  @override
  FutureOr<List<Bank>> build() {
    return Bank.getList();
  }
}
