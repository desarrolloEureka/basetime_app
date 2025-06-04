import 'package:basetime/features/wallet/wallet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wallet_state.g.dart';

@riverpod
Stream<Wallet?> walletState(Ref ref) {
  return Wallet.getMyWallet();
}
