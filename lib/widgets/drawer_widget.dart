import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/core/utils/string_extension.dart';
import 'package:basetime/features/my_account/my_account_page.dart';
import 'package:basetime/features/payments/payments_page.dart';
import 'package:basetime/features/settings/legal_state.dart';
import 'package:basetime/features/skills/skills_page.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerBT extends ConsumerWidget {
  DrawerBT({super.key, this.onClose});

  final VoidCallback? onClose;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final legalState = ref.watch(legalStateProvider);
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton.filled(
                  onPressed: onClose,
                  icon: const Icon(Icons.menu_rounded),
                ),
              ],
            ),
          ),
          legalState.when(
            data: (legal) {
              return Column(
                children: ListTile.divideTiles(
                  color: Colors.white,
                  tiles: [
                    if (legal.policyURL != null)
                      ListTile(
                        onTap: () {
                          launchUrl(
                            Uri.parse(legal.policyURL!),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        title: Text(
                          context.lang!.privacyPolicies.capitalize(),
                        ),
                        titleTextStyle: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                    if (legal.termsURL != null)
                      ListTile(
                        onTap: () {
                          launchUrl(
                            Uri.parse(legal.termsURL!),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        title: Text(
                          context.lang!.termsAndConditions.capitalize(),
                        ),
                        titleTextStyle: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                  ],
                ).toList(),
              );
            },
            error: (context, stackTrace) {
              return Text('$context: $stackTrace');
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),

          /// Skills
          ListTile(
            onTap: () {
              context.push(SkillsPage.path);
            },
            title: Text(context.lang!.completeProfile),
            titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),

          /// My account
          ListTile(
            onTap: () {
              context.push(MyAccountPage.path);
            },
            title: Text(context.lang!.myAccount),
            titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),

          /// Payments
          ListTile(
            onTap: () {
              context.push(PaymentsPage.path);
            },
            title: Text(context.lang!.payments),
            titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),

          /// Sign out
          ListTile(
            onTap: () async {
              final result = await context.showConfirm<bool>(
                content: context.lang!.signOutAlert,
                onConfirm: () {
                  context.pop(true);
                },
              );

              if (result == true) {
                await auth.signOut();
                if (context.mounted) {
                  context.pushReplacement(WelcomePage.path);
                }
              }
            },
            title: Text(context.lang!.signOut),
            titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),

          /// Delete user
          ListTile(
            onTap: () async {
              final result = await context.showConfirm<bool>(
                content: context.lang!.deleteAccount,
                onConfirm: () {
                  context.pop(true);
                },
              );

              if (result == true) {
                // await auth.signOut();
                // if (context.mounted) {
                //   context.pushReplacement(WelcomePage.path);
                // }
              }
            },
            title: Text(context.lang!.deleteAccount),
            titleTextStyle: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
