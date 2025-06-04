import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_form.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBankAccountPage extends ConsumerStatefulWidget {
  const AddBankAccountPage({super.key});

  static String name = 'add-bank-account';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddBankAccountPageState();
}

class _AddBankAccountPageState extends ConsumerState<AddBankAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      appBar: AppBarBT(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          context.lang!.newPaymentAccount,
          style: GoogleFonts.ubuntu(
            color: Colors.red[900],
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListTile(
            onTap: () async {
              final result = await context.push<bool>(
                AddBankAccountForm.path,
                extra: AccountType.saving,
              );

              if ((result ?? false) && context.mounted) {
                context.pop();
              }
            },
            tileColor: Theme.of(context).colorScheme.surface,
            leading: const Icon(Icons.wallet_rounded),
            title: Text(context.lang!.savingAccount),
          ),
          const SizedBox(height: 16),
          ListTile(
            onTap: () async {
              final result = await context.push<bool>(
                AddBankAccountForm.path,
                extra: AccountType.checking,
              );

              if ((result ?? false) && context.mounted) {
                context.pop();
              }
            },
            tileColor: Theme.of(context).colorScheme.surface,
            leading: const Icon(Icons.wallet_rounded),
            title: Text(context.lang!.checkingAccount),
          ),
        ],
      ),
    );
  }
}

enum AccountType {
  saving,
  checking,
}
