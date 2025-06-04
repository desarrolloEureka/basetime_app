import 'package:basetime/core/context/context_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Forgot password page
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  static String name = 'forgot-password';
  static String path = '/$name';

  @override
  ConsumerState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  /// Variables
  bool _loadingSend = false;

  /// Global keys
  final _formKey = GlobalKey<FormState>();

  /// Form controllers
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context, ref),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: _loadingSend
                  ? () {}
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loadingSend = true;
                        });
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text,
                          );
                          if (context.mounted) {
                            await context.showAlert<void>(
                              content: context
                                  .lang!.sendRecoveryPasswordAlertContent,
                            );
                            if (context.mounted) {
                              context.pop();
                            }
                          }
                        } catch (error) {
                          if (context.mounted) {
                            context.showBanner(message: error.toString());
                          }
                        }
                        setState(() {
                          _loadingSend = false;
                        });
                      }
                    },
              child: _loadingSend
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(context.lang!.next),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(Icons.arrow_circle_left_outlined),
      ),
      title: Text(context.lang!.forgotPassword),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Text(
                  context.lang!.forgotPasswordMessage,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),

                /// Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: context.lang!.email,
                  ),
                  validator: ValidationBuilder(
                    requiredMessage: context.lang!.thisFieldIsRequired,
                  ).email(context.lang!.validEmail).build(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
