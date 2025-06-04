import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessPage extends ConsumerStatefulWidget {
  const PaymentSuccessPage({super.key});

  static String name = 'payment-success';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends ConsumerState<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBT(),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.lang!.paymentSuccess,
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              FilledButton(
                onPressed: () async {
                  context.pop(true);
                },
                child: Text(context.lang!.activeMatch),
              ),
              Image.asset('assets/success-payment.png'),
            ],
          ),
        ),
      ),
    );
  }
}
