import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/bank_accounts/add_bank_account_page.dart';
import 'package:basetime/features/bank_accounts/banks_accounts_state.dart';
import 'package:basetime/features/payments/add_payment_method_page.dart';
import 'package:basetime/features/payments/payments_state.dart';
import 'package:basetime/features/wallet/wallet_page.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Payments Page
class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({super.key});

  static String name = 'payments';
  static String path = '/payments';

  @override
  ConsumerState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends ConsumerState<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    final paymentMethodsState = ref.watch(paymentMethodsStateProvider);
    final paymentMethodsNotifier = ref.read(
      paymentMethodsStateProvider.notifier,
    );
    final banksAccountState = ref.watch(banksAccountsStateProvider);
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: !ModalRoute.of(context)!.isFirst
            ? IconButton(
                onPressed: context.pop,
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                ),
              )
            : IconButton(
                onPressed: () {
                  context.pushReplacement(WelcomePage.path);
                },
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                ),
              ),
        titleTextStyle: GoogleFonts.ubuntu(
          color: Colors.red,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        title: Text(context.lang!.payments),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: MaterialButton(
                  onPressed: () {
                    context.push(WalletPage.path);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/BTP.svg',
                        width: 64,
                        height: 64,
                      ),
                      Text(
                        'BTP',
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        context.lang!.points,
                        style: GoogleFonts.ubuntu(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Credits cards
              Container(
                color: Theme.of(context).colorScheme.surface,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.lang!.myPaymentMethods,
                          style: GoogleFonts.ubuntu(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(
                              AddPaymentMethodPage.path,
                            );
                          },
                          child: Text(context.lang!.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    paymentMethodsState.when(
                      data: (methods) {
                        return methods.isEmpty
                            ? Center(
                                child: Text(
                                  context.lang!.emptyPaymentMethods,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Column(
                                children: List<Widget>.from(
                                  methods.map((method) {
                                    return ListTile(
                                      leading: const Icon(Icons.credit_card),
                                      title: Text(
                                        method.name,
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          await paymentMethodsNotifier.delete(
                                            method,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                      },
                      error: (error, stackTrace) {
                        return Text('$error: $stackTrace');
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Bank Accounts
              Container(
                color: Theme.of(context).colorScheme.surface,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.lang!.myPaymentAccounts,
                          style: GoogleFonts.ubuntu(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(
                              AddBankAccountPage.path,
                            );
                          },
                          child: Text(context.lang!.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    banksAccountState.when(
                      data: (accounts) {
                        return accounts.isEmpty
                            ? Center(
                                child: Text(
                                  context.lang!.emptyPaymentMethods,
                                  style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Column(
                                children: List<Widget>.from(
                                  accounts.map(
                                    (account) {
                                      if (account.bank == 'NEQUI') {
                                        return ListTile(
                                          leading: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 6,
                                            ).copyWith(top: 8),
                                            child: SvgPicture.asset(
                                              'assets/logos/nequi.svg',
                                              width: 16,
                                              height: 16,
                                            ),
                                          ),
                                          title: Text(account.bank),
                                          subtitle: Text(account.number),
                                          titleTextStyle: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                          ),
                                          trailing: IconButton(
                                            onPressed: () => ref
                                                .read(
                                                  banksAccountsStateProvider
                                                      .notifier,
                                                )
                                                .delete(account),
                                            icon: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListTile(
                                          leading: const Icon(
                                            Icons.account_balance_rounded,
                                          ),
                                          title: Text(account.bank),
                                          titleTextStyle: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                account.type ==
                                                        AccountType.saving
                                                    ? context
                                                        .lang!.savingAccount
                                                    : context
                                                        .lang!.checkingAccount,
                                              ),
                                              Text(account.number),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () => ref
                                                .read(
                                                  banksAccountsStateProvider
                                                      .notifier,
                                                )
                                                .delete(account),
                                            icon: const Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                      },
                      error: (error, stackTrace) {
                        return Text('$error: $stackTrace');
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
