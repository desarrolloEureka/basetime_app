import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/core/utils/currency.dart';
import 'package:basetime/features/wallet/movements_bottom_sheet.dart';
import 'package:basetime/features/wallet/wallet_state.dart';
import 'package:basetime/features/welcome/welcome_page.dart';
import 'package:basetime/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  static String name = 'wallet';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletStateProvider);
    return Scaffold(
      key: _scaffoldKey,
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
        title: Text('BTP ${context.lang!.points}'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
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
                  walletState.when(
                    data: (wallet) {
                      if (wallet == null) {
                        return Container();
                      }
                      return Column(
                        children: [
                          Text(
                            Currency(amount: wallet.balance).cop,
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${context.lang!.payments} '
                            '${Currency(amount: wallet.refund).cop}',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Total '
                            '${Currency(
                              amount: wallet.balance + wallet.refund,
                            ).cop}',
                            style: GoogleFonts.ubuntu(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                    error: (error, stackTrace) => ShowError(
                      error: error,
                      stackTrace: stackTrace,
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.lang!.balanceDescription,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.lang!.balancePriceDescription,
                    style: GoogleFonts.ubuntu(
                      color: Colors.red[900],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      walletState.when(
                        data: (wallet) {
                          if (wallet == null) {
                            return Container();
                          }
                          return FilledButton(
                            onPressed: wallet.balance > 0
                                ? () {
                                    _scaffoldKey.currentState!.showBottomSheet(
                                      (context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: 16,
                                            children: [
                                              AppBar(
                                                leading: const Icon(
                                                  Icons
                                                      .account_balance_wallet_rounded,
                                                ),
                                                title: const Text('Balance'),
                                                actions: [
                                                  IconButton(
                                                    onPressed: context.pop,
                                                    icon:
                                                        const Icon(Icons.close),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '\$${NumberFormat.currency(
                                                  locale: 'es-ES',
                                                  name: 'COP',
                                                  decimalDigits: 2,
                                                ).format(wallet.balance)}',
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 32,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FilledButton(
                                                    onPressed:
                                                        wallet.balance == 0
                                                            ? null
                                                            : () {},
                                                    child: Text(
                                                      context.lang!
                                                          .requestWithdrawal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                : null,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              context.lang!.requestWithdrawal,
                              style: GoogleFonts.ubuntu(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) => ShowError(
                          error: error,
                          stackTrace: stackTrace,
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.showBottomSheet(
                            (context) => const MovementsBottomSheet(),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.visibility, color: Colors.red[900]),
                            Text(
                              context.lang!.movements,
                              style: GoogleFonts.ubuntu(
                                color: Colors.red[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
