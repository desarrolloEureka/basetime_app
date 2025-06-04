import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/core/validations/validations_extension.dart';
import 'package:basetime/features/auth/auth_repository.dart';
import 'package:basetime/features/settings/legal_state.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static String name = 'sign-up';
  static String path = '/sign-up';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  /// Variables
  bool _hidePassword = true;
  bool _acceptedTerms = false;
  bool _isAdult = false;
  bool _loadingSignUp = false;

  /// Global keys
  final _formKey = GlobalKey<FormState>();

  /// Form controllers
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _promoterIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final legalState = ref.watch(legalStateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
        title: Text(context.lang!.createAccount),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  /// Firstname
                  TextFormField(
                    controller: _firstnameController,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: context.lang!.firstname,
                    ),
                    validator: ValidationBuilder(
                      requiredMessage: context.lang!.thisFieldIsRequired,
                    ).build(),
                  ),

                  /// Lastname
                  TextFormField(
                    controller: _lastnameController,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: context.lang!.lastname,
                    ),
                    validator: ValidationBuilder(
                      requiredMessage: context.lang!.thisFieldIsRequired,
                    ).build(),
                  ),

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

                  /// ID
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: context.lang!.id,
                    ),
                    validator: ValidationBuilder(
                      requiredMessage: context.lang!.thisFieldIsRequired,
                    ).build(),
                  ),

                  /// Promoter ID
                  TextFormField(
                    controller: _promoterIdController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: '${context.lang!.promoterId} '
                          '(${context.lang!.optional})',
                    ),
                  ),

                  /// Password
                  TextFormField(
                    controller: _passwordController,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: context.lang!.password,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    obscureText: _hidePassword,
                    validator: ValidationBuilder(
                      requiredMessage: context.lang!.thisFieldIsRequired,
                    )
                        .minLength(8, context.lang!.password8length)
                        .password(context.lang!.passwordShouldNotPassword)
                        .build(),
                  ),

                  /// Verificar Password
                  TextFormField(
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: context.lang!.verifyPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    obscureText: _hidePassword,
                    validator: ValidationBuilder(
                      requiredMessage: context.lang!.thisFieldIsRequired,
                    )
                        .minLength(8, context.lang!.password8length)
                        .isSame(
                          context.lang!.passwordVerification,
                          _passwordController.text,
                        )
                        .build(),
                  ),

                  const SizedBox(height: 16),

                  /// Terms and conditions
                  legalState.when(
                    data: (legal) {
                      return Row(
                        children: [
                          Checkbox(
                              value: _acceptedTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptedTerms = value!;
                                });
                              }),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: '${context.lang!.iAgreeToHaveRead} ',
                                children: [
                                  TextSpan(
                                    text: context.lang!.termsAndConditions,
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.red,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(
                                          Uri.parse(legal.termsURL!),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                  ),
                                  TextSpan(
                                    text: ' ${context.lang!.and} ',
                                  ),
                                  TextSpan(
                                    text: context.lang!.privacyPolicies,
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.red,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(
                                          Uri.parse(legal.policyURL!),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                  ),
                                ],
                                style: GoogleFonts.ubuntu(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      return Text('$error: $stackTrace');
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  Row(
                    children: [
                      Checkbox(
                          value: _isAdult,
                          onChanged: (value) {
                            setState(() {
                              _isAdult = value!;
                            });
                          }),
                      Text(
                        context.lang!.majorYearsOld,
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: _loadingSignUp
                  ? () {}
                  : _acceptedTerms && _isAdult
                      ? () => signIn(context)
                      : null,
              child: _loadingSignUp
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

  /// Functions
  Future<void> signIn(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _loadingSignUp = true;
        });
        try {
          final id = int.parse(_idController.text);
          final promoterID = int.parse(
            _promoterIdController.text.isEmpty
                ? '0'
                : _promoterIdController.text,
          );

          /// Validate Ids
          final validID = await AuthRepository().uniqueID(id);
          final validPromoterID = await AuthRepository().uniqueID(promoterID);

          if (!validID) {
            if (context.mounted) {
              await context.showConfirm<bool>(
                content: context.lang!.invalidID,
                onConfirm: context.pop,
              );
            }
            setState(() {
              _loadingSignUp = false;
            });
            return;
          }

          if (validPromoterID && promoterID > 0) {
            if (context.mounted) {
              await context.showConfirm<bool>(
                content: context.lang!.invalidPromoterID,
                onConfirm: context.pop,
              );
            }
            setState(() {
              _loadingSignUp = false;
            });
            return;
          }

          await AuthRepository().signUp(
            firstname: _firstnameController.text,
            lastname: _lastnameController.text,
            email: _emailController.text,
            id: int.parse(_idController.text),
            promoterId: _promoterIdController.text.isNotEmpty
                ? int.parse(_promoterIdController.text)
                : null,
            password: _passwordController.text,
          );
          if (context.mounted) {
            context.pushReplacement(WelcomePage.path);
          }
        } catch (error) {
          if (context.mounted) {
            context.showBanner(message: error.toString());
          }
        }
        setState(() {
          _loadingSignUp = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
