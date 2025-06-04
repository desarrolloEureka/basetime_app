import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/bank_accounts/bank_account.dart';
import 'package:basetime/features/bank_accounts/banks_accounts_state.dart';
import 'package:basetime/features/chats/chat.dart';
import 'package:basetime/features/checkout/payment_failed_page.dart';
import 'package:basetime/features/checkout/payment_success_page.dart';
import 'package:basetime/features/matches/match.dart';
import 'package:basetime/features/meets/meet.dart';
import 'package:basetime/features/meets/meet_page.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:basetime/features/payments/payments_page.dart';
import 'package:basetime/features/payments/payments_state.dart';
import 'package:basetime/features/wallet/wallet_state.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:basetime/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({
    super.key,
    required this.match,
    required this.chat,
    required this.meet,
  });

  final MatchModel match;
  final Chat chat;
  final Meet meet;

  static String name = 'checkout';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  int installementsNumber = 1;
  PaymentMethod? selectedPaymentMethod;
  BankAccount? selectedBankAccount;
  bool processing = false;
  bool useBTP = false;

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletStateProvider);
    final paymentMethodsState = ref.watch(paymentMethodsStateProvider);
    final banksAccountState = ref.watch(banksAccountsStateProvider);
    if (paymentMethodsState.isLoading || banksAccountState.isLoading) {
      return const Loader();
    }
    final paymentMethods = paymentMethodsState.value!;
    final banksAccounts = banksAccountState.value
            ?.where(
              (e) => e.bank == 'NEQUI',
            )
            .toList() ??
        [];

    if (processing) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Procesando pago...',
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarBT(
        title: Text(context.lang!.paymentData),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF313131),
              padding: const EdgeInsets.all(16).copyWith(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      context.lang!.meetTime,
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        context.lang!.hours(widget.match.hours),
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF313131),
              padding: const EdgeInsets.all(16).copyWith(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!useBTP)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedPaymentMethod == null &&
                                    selectedBankAccount == null
                                ? context.lang!.youMustSelectAPaymentMethod
                                : context.lang!.paymentMethod,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                context.lang!
                                                    .selectYourPaymentMethod,
                                              ),
                                              IconButton(
                                                onPressed: context.pop,
                                                icon: const Icon(Icons.close),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        if (paymentMethods.isEmpty &&
                                            banksAccounts.isEmpty)
                                          FilledButton(
                                            onPressed: () {
                                              context
                                                ..pop()
                                                ..replace(PaymentsPage.path);
                                            },
                                            child: Text(
                                              context.lang!.addPaymentMethod,
                                            ),
                                          ),
                                        ...List<Widget>.from(
                                          paymentMethods.map(
                                            (method) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPaymentMethod =
                                                        method;
                                                    selectedBankAccount = null;
                                                  });
                                                  context.pop();
                                                },
                                                leading: Checkbox(
                                                  value: selectedPaymentMethod
                                                          ?.id ==
                                                      method.id,
                                                  onChanged: (_) {
                                                    setState(() {
                                                      selectedPaymentMethod =
                                                          method;
                                                      selectedBankAccount =
                                                          null;
                                                    });
                                                    context.pop();
                                                  },
                                                ),
                                                title: Text(
                                                  '${method.brand} ${method.lastFour}',
                                                ),
                                                subtitle:
                                                    Text(method.cardHolder),
                                                trailing: const Icon(
                                                  Icons.chevron_right,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        ...List<Widget>.from(
                                          banksAccounts.map(
                                            (bank) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPaymentMethod =
                                                        null;
                                                    selectedBankAccount = bank;
                                                  });
                                                  context.pop();
                                                },
                                                leading: Checkbox(
                                                  value:
                                                      selectedBankAccount?.id ==
                                                          bank.id,
                                                  onChanged: (_) {
                                                    setState(() {
                                                      selectedPaymentMethod =
                                                          null;
                                                      selectedBankAccount =
                                                          bank;
                                                    });
                                                    context.pop();
                                                  },
                                                ),
                                                title: Text(
                                                  '${bank.bank} ${bank.number}',
                                                ),
                                                subtitle: Text(bank.titular),
                                                trailing: const Icon(
                                                  Icons.chevron_right,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // if (user?.nequiNumber.isNotNull ?? false)
                                        //   ListTile(
                                        //     onTap: () {
                                        //       setState(() {
                                        //         selectedPaymentMethod =
                                        //             user!.nequiNumber!;
                                        //       });
                                        //       context.pop();
                                        //     },
                                        //     leading: Checkbox(
                                        //       value: selectedPaymentMethod !=
                                        //               null &&
                                        //           selectedPaymentMethod is String,
                                        //       onChanged: (_) {
                                        //         setState(() {
                                        //           selectedPaymentMethod =
                                        //               user!.nequiNumber!;
                                        //         });
                                        //         context.pop();
                                        //       },
                                        //     ),
                                        //     title: const Text('NEQUI'),
                                        //     trailing: const Icon(
                                        //       Icons.chevron_right,
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              selectedPaymentMethod == null &&
                                      selectedBankAccount == null
                                  ? context.lang!.select
                                  : context.lang!.change,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (selectedPaymentMethod != null ||
                      selectedBankAccount != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (selectedPaymentMethod != null)
                              const Icon(
                                Icons.credit_card_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                            if (selectedBankAccount != null)
                              const Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                            Column(
                              spacing: 2,
                              children: [
                                if (selectedPaymentMethod != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${selectedPaymentMethod?.brand ?? ''} ${selectedPaymentMethod?.lastFour ?? ''}',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        selectedPaymentMethod?.cardHolder ?? '',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectedBankAccount != null)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${selectedBankAccount?.bank ?? ''} ${selectedBankAccount?.number ?? ''}',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        selectedBankAccount?.titular ?? '',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                        if (selectedPaymentMethod != null)
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                context.lang!.numberOfInstallments,
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (installementsNumber < 36) {
                                        setState(() {
                                          installementsNumber++;
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    installementsNumber.toString(),
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (installementsNumber > 1) {
                                        setState(() {
                                          installementsNumber--;
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  const SizedBox(height: 16),
                  if ((walletState.value?.balance ?? 0) > 0 ||
                      (walletState.value?.refund ?? 0) > 0)
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.red,
                          size: 32,
                        ),
                        Column(
                          children: [
                            Text(
                              context.lang!.useBTP,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                              ),
                            ),
                            Text(
                              context.lang!.copInFavor(
                                (walletState.value?.balance ?? 0) +
                                    (walletState.value?.refund ?? 0),
                              ),
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: useBTP,
                          onChanged: (bool? value) {
                            setState(() {
                              useBTP = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  //   Wrap(
                  //     spacing: 4,
                  //     crossAxisAlignment: WrapCrossAlignment.center,
                  //     children: [
                  //       const Icon(
                  //         Icons.monetization_on_outlined,
                  //         color: Colors.red,
                  //         size: 32,
                  //       ),
                  //       Wrap(
                  //         direction: Axis.vertical,
                  //         children: [
                  //           Text(
                  //             context.lang!.useBTP,
                  //             style: GoogleFonts.ubuntu(
                  //               color: Colors.red,
                  //               fontSize: 20,
                  //               decoration: TextDecoration.underline,
                  //               decorationColor: Colors.red,
                  //             ),
                  //           ),
                  //           Text(
                  //             context.lang!.copInFavor(
                  //               walletState.value?.balance ?? 0,
                  //             ),
                  //             style: GoogleFonts.ubuntu(
                  //               color: Colors.white,
                  //               fontSize: 10,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Checkbox(
                  //         value: false,
                  //         onChanged: (value) {},
                  //         side: const BorderSide(
                  //           width: 2,
                  //           color: Colors.red,
                  //         ),
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: useBTP ||
              selectedPaymentMethod != null ||
              selectedBankAccount != null
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Padding(
                  //  padding: const EdgeInsets.all(16),
                  //  child: Wrap(
                  //    direction: Axis.vertical,
                  //    spacing: 16,
                  //    children: [
                  //      Text(
                  //        context.lang!.discountCoupon,
                  //        style: GoogleFonts.ubuntu(
                  //          color: Colors.white,
                  //        ),
                  //      ),
                  //      FilledButton(
                  //        style: FilledButton.styleFrom(
                  //          backgroundColor: Colors.transparent,
                  //          minimumSize: Size(
                  //            MediaQuery.of(context).size.width - 32,
                  //            49,
                  //          ),
                  //          shape: RoundedRectangleBorder(
                  //            borderRadius: BorderRadius.circular(100),
                  //            side: const BorderSide(
                  //              width: 2,
                  //              color: Colors.white,
                  //            ),
                  //          ),
                  //        ),
                  //        onPressed: () {},
                  //        child: Text(context.lang!.redeemCoupon),
                  //      ),
                  //    ],
                  //  ),
                  //),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    padding: const EdgeInsets.all(16).copyWith(
                      bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              context.lang!.total,
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              context.lang!
                                  .dollars(
                                    widget.match.service.pricePerHour *
                                        widget.match.hours,
                                  )
                                  .toUpperCase(),
                              style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            elevation: 15,
                          ),
                          onPressed: () async {
                            final result = await showModalBottomSheet<bool>(
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    children: [
                                      Text(
                                        context.lang!.sureOrderedNow,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 20,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FilledButton(
                                            style: FilledButton.styleFrom(
                                              elevation: 6,
                                              minimumSize: const Size(32, 42),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () => context.pop(true),
                                            child: Text(context.lang!.yes),
                                          ),
                                          FilledButton(
                                            style: FilledButton.styleFrom(
                                              elevation: 6,
                                              minimumSize: const Size(32, 42),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: context.pop,
                                            child: Text(context.lang!.no),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );

                            if (result != null) {
                              setState(() {
                                processing = true;
                              });
                              if (useBTP && context.mounted) {
                                final wallet = walletState.value;
                                if (wallet == null && context.mounted) {
                                  await context.push(PaymentFailedPage.path);
                                  return;
                                }
                                final balance = wallet!.balance + wallet.refund;
                                final amount = widget.match.hours *
                                    widget.match.service.pricePerHour;
                                if (balance < amount) {
                                  await context.showAlert<void>(
                                    content: 'No cuenta con saldo suficiente',
                                    onConfirm: context.pop,
                                    confirmText: 'OK',
                                  );
                                  setState(() {
                                    processing = false;
                                  });
                                  return;
                                }
                                await wallet.payment(
                                  widget.match,
                                  widget.meet,
                                );
                                if (context.mounted) {
                                  final result = await context.push<bool>(
                                    PaymentSuccessPage.path,
                                  );

                                  if (result ?? false) {
                                    if (context.mounted) {
                                      context.replace(
                                        MeetPage.path,
                                        extra: {
                                          'match': widget.match,
                                          'chat': widget.chat,
                                          'meet': widget.meet,
                                        },
                                      );
                                    }
                                  } else if (context.mounted) {
                                    context.pop();
                                  }
                                  return;
                                }
                              }
                              final paymentResult =
                                  await selectedPaymentMethod?.payment(
                                        amountInCents: ((widget.match.hours *
                                                    widget.match.service
                                                        .pricePerHour) *
                                                100)
                                            .toInt(),
                                        installments: installementsNumber,
                                      ) ??
                                      await selectedBankAccount?.payment(
                                        amountInCents: ((widget.match.hours *
                                                    widget.match.service
                                                        .pricePerHour) *
                                                100)
                                            .toInt(),
                                      );

                              if (paymentResult?['status'] == 'APPROVED') {
                                await widget.meet.update({
                                  'status': MeetStatus.aceptPayed.name,
                                  'service': widget.match.service.id,
                                  'amount': widget.match.hours *
                                      widget.match.service.pricePerHour,
                                  'hours': widget.match.hours,
                                });

                                if (context.mounted) {
                                  final result = await context.push<bool>(
                                    PaymentSuccessPage.path,
                                  );

                                  if (result ?? false) {
                                    if (context.mounted) {
                                      context.replace(
                                        MeetPage.path,
                                        extra: {
                                          'match': widget.match,
                                          'chat': widget.chat,
                                          'meet': widget.meet,
                                        },
                                      );
                                    }
                                  } else if (context.mounted) {
                                    context.pop();
                                  }
                                }
                              } else if (context.mounted) {
                                await context.push(PaymentFailedPage.path);
                              }
                              setState(() {
                                processing = false;
                              });
                            }
                          },
                          child: Text(context.lang!.makePayment),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
