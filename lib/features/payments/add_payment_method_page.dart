import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/payments/add_payment_method_form.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddPaymentMethodPage extends ConsumerStatefulWidget {
  const AddPaymentMethodPage({super.key});

  static String name = 'Add Payment Method';
  static String path = '/add-payment-method';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends ConsumerState<AddPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.lang!.addPaymentMethod),
      ),
      body: Column(
        children: [
          Text(
            context.lang!.selectYourPaymentMethod,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: ListTile.divideTiles(
                color: Colors.white70,
                tiles: [
                  ListTile(
                    onTap: () {
                      context
                          .push<bool>(
                        AddPaymentMethodForm.path,
                        extra: PaymentMethodType.creditCard,
                      )
                          .then(
                        (result) {
                          if (result == true && context.mounted) {
                            context.pop();
                          }
                        },
                      );
                    },
                    leading: const Icon(Icons.credit_card),
                    title: Text(context.lang!.creditCard),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    onTap: () {
                      context
                          .push<bool>(
                        AddPaymentMethodForm.path,
                        extra: PaymentMethodType.debitCard,
                      )
                          .then(
                        (result) {
                          if (result == true && context.mounted) {
                            context.pop();
                          }
                        },
                      );
                    },
                    leading: const Icon(Icons.credit_card),
                    title: Text(context.lang!.debitCard),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
