import 'package:basetime/core/context/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationSuccess extends ConsumerStatefulWidget {
  const VerificationSuccess({super.key});

  static String name = 'verification-success';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationSuccessState();
}

class _VerificationSuccessState extends ConsumerState<VerificationSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 256,
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  context.lang!.uploadDataSuccess,
                  style: GoogleFonts.ubuntu(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.lang!.verifyAgentNotification,
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Ok',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
