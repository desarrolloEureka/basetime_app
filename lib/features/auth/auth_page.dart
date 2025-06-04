import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/auth/sign_in_page.dart';
import 'package:basetime/features/auth/sign_up_page.dart';
import 'package:basetime/features/home/home_page.dart';
import 'package:basetime/l10n/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  static String name = 'Auth';
  static String path = '/auth';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final localeNotifier = ref.read(localeStateProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  fit: BoxFit.cover,
                ),
                TextButton(
                  onPressed: () {
                    localeNotifier.change(context);
                  },
                  child: Text(context.lang!.selectLang),
                ),
                const SizedBox(height: 32),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () {
                    context.push(SignUpPage.path);
                  },
                  child: Text(context.lang!.createAccount),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () {
                    context.pushNamed(SignInPage.name);
                  },
                  child: Text(context.lang!.signIn),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  label: Text(context.lang!.signInWithFacebook),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pushReplacementNamed(HomePage.name);
                      },
                      child: Text(
                        context.lang!.signUpLater,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
