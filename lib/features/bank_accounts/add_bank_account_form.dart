import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_page.dart';
import 'package:basetime/features/bank_accounts/bank_account.dart';
import 'package:basetime/features/bank_accounts/banks_accounts_state.dart';
import 'package:basetime/features/bank_accounts/banks_state.dart';
import 'package:basetime/features/settings/legal_state.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AddBankAccountForm extends ConsumerStatefulWidget {
  const AddBankAccountForm({super.key, required this.accountType});

  static String name = 'add-back-account-form';
  static String path = '/$name';

  final AccountType accountType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddBankAccountFormState();
}

class _AddBankAccountFormState extends ConsumerState<AddBankAccountForm> {
  bool _loading = false;
  bool _acceptedTerms = false;
  String _selectedBankName = 'not-bank';

  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _titularController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      final banks = ref.watch(banksStateProvider).value!;
      setState(() {
        _selectedBankName = banks.first.name;
      });
    });
  }

  Future<void> _addAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await ref.read(banksAccountsStateProvider.notifier).add(
            BankAccount(
              bank: _selectedBankName,
              createdAt: DateTime.now(),
              id: '',
              number: _accountNumberController.text,
              titular: _titularController.text,
              type: widget.accountType,
              userID: FirebaseAuth.instance.currentUser!.uid,
            ),
          );
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        context.pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final banksState = ref.watch(banksStateProvider);
    final legalState = ref.watch(legalStateProvider);

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      appBar: AppBarBT(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          context.lang!.accountData(
            widget.accountType == AccountType.saving
                ? context.lang!.savingAccount
                : context.lang!.checkingAccount,
          ),
          style: GoogleFonts.ubuntu(
            color: Colors.red[900],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.lang!.bank),
              const SizedBox(height: 8),
              banksState.when(
                data: (banks) {
                  if (banks.isEmpty) {
                    return Container();
                  }
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    value: _selectedBankName,
                    items: [
                      DropdownMenuItem(
                        value: 'not-bank',
                        child: Text(context.lang!.selectABank),
                      ),
                      ...List<DropdownMenuItem<String>>.from(
                        banks.map(
                          (bank) {
                            return DropdownMenuItem(
                              value: bank.name,
                              child: Text(bank.name),
                            );
                          },
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedBankName =
                            value! == 'not-bank' ? banks.first.name : value;
                      });
                    },
                  );
                },
                error: (Object error, StackTrace stackTrace) {
                  return ShowError(
                    error: error,
                    stackTrace: stackTrace,
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),

              /// Account Number
              const SizedBox(height: 16),
              Text(context.lang!.accountNumber),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _accountNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: FormBuilderValidators.required(),
              ),

              /// Titual Name
              const SizedBox(height: 16),
              Text(context.lang!.titularName),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titularController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: FormBuilderValidators.required(),
              ),

              /// Terms and conditions
              const SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).viewPadding.bottom + 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: _loading || !_acceptedTerms ? null : _addAccount,
              child: Text(_loading ? context.lang!.loading : context.lang!.add),
            ),
          ],
        ),
      ),
    );
  }
}
