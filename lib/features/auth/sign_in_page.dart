import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/auth_repository.dart';
import 'package:basetime/features/auth/forgot_password_page.dart';
import 'package:basetime/features/home/home_page.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  static String name = 'SignIn';
  static String path = '/sign-in';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  bool _hidePassword = true;
  bool _loadingSignIn = false;

  final repository = AuthRepository();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/sign-in-bg.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarBT(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(context.lang!.signIn),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icon.png',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.cover,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: context.lang!.email,
                        ),
                        validator: ValidationBuilder(
                          requiredMessage: context.lang!.thisFieldIsRequired,
                        ).email(context.lang!.validEmail).build(),
                      ),
                      TextFormField(
                        controller: _passwordController,
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
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        obscureText: _hidePassword,
                        validator: ValidationBuilder(
                          requiredMessage: context.lang!.thisFieldIsRequired,
                        ).build(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.push(ForgotPasswordPage.path);
                            },
                            child: Text(context.lang!.forgotPassword),
                          )
                        ],
                      )
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
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(165, 44),
                    shadowColor: Colors.black.withValues(alpha: 0.4),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loadingSignIn = true;
                      });
                      final result = await repository.signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      result.fold(
                        (l) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l.message ?? ''),
                            ),
                          );
                          setState(() {
                            _loadingSignIn = false;
                          });
                        },
                        (r) => context.go(HomePage.path),
                      );
                    }
                  },
                  child: _loadingSignIn
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          context.lang!.next,
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
