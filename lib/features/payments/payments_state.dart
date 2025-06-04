import 'package:basetime/features/payments/payment_method.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payments_state.g.dart';

@riverpod
class PaymentMethodsState extends _$PaymentMethodsState {
  @override
  FutureOr<List<PaymentMethod>> build() {
    return PaymentMethod.fetch();
  }

  Future<void> addMethod({
    required String number,
    required String cvc,
    required String expMonth,
    required String expYear,
    required String cardHolder,
  }) async {
    state = const AsyncLoading();
    await PaymentMethod.create(
      number: number,
      cvc: cvc,
      expMonth: expMonth,
      expYear: expYear,
      cardHolder: cardHolder,
    );
    state = await AsyncValue.guard(PaymentMethod.fetch);
  }

  Future<void> delete(PaymentMethod paymentMethod) async {
    state = const AsyncLoading();
    await paymentMethod.delete();
    state = await AsyncValue.guard(PaymentMethod.fetch);
  }
}
