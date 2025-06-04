import 'package:basetime/features/bank_accounts/bank_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banks_accounts_state.g.dart';

@riverpod
class BanksAccountsState extends _$BanksAccountsState {
  @override
  FutureOr<List<BankAccount>> build() {
    return BankAccount.getMyList();
  }

  Future<void> add(BankAccount account) async {
    state = const AsyncLoading();
    await account.add();
    state = await AsyncValue.guard(BankAccount.getMyList);
  }

  Future<void> delete(BankAccount account) async {
    state = const AsyncLoading();
    await account.delete();
    state = await AsyncValue.guard(BankAccount.getMyList);
  }
}
