import 'package:basetime/core/context/context_extension.dart';
import 'package:basetime/features/payments/payment_method.dart';
import 'package:basetime/features/payments/payments_state.dart';
import 'package:basetime/features/settings/legal_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AddPaymentMethodForm extends ConsumerStatefulWidget {
  const AddPaymentMethodForm({super.key, required this.type});

  static String name = 'Add Payment Method Type';
  static String path = '/add-payment-method-type';

  final PaymentMethodType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPaymentMethodFormState();
}

class _AddPaymentMethodFormState extends ConsumerState<AddPaymentMethodForm> {
  bool _loadingSave = false;
  bool _acceptedTerms = false;
  String _displayNumber = '**** **** **** ****';
  String _expirationDate = '12/27';
  String? _titularName;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expirationController = TextEditingController(text: '12/27');
  final _cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _expirationController.addListener(_formatInput);
  }

  @override
  void dispose() {
    _expirationController.removeListener(_formatInput);
    super.dispose();
  }

  void _updateText(String value) {
    final digits = value.replaceAll(' ', '');

    if (digits.isEmpty) {
      setState(() {
        _displayNumber = '**** **** **** ****';
      });
      return;
    }

    String masked = digits.padRight(16, '*');
    masked = _groupIntoFours(masked);
    setState(() {
      _displayNumber = masked;
    });
  }

  String _groupIntoFours(String input) {
    return input
        .replaceAllMapped(RegExp('.{1,4}'), (match) => '${match.group(0)} ')
        .trim();
  }

  void _formatInput() {
    String text = _expirationController.text;

    // Remover cualquier carácter no numérico y limitar a 4 caracteres
    text = text.replaceAll(RegExp('[^0-9]'), '');
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    // Formatear el texto como MM/AA
    if (text.length >= 3) {
      final month = text.substring(0, 2);
      final year = text.substring(2);
      text = '$month/$year';
    }

    // Evitar un bucle infinito al asignar el texto
    if (text != _expirationController.text) {
      _expirationController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final legalState = ref.watch(legalStateProvider);
    final paymentsNotifier = ref.read(paymentMethodsStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type.langName(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8).copyWith(top: 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FittedBox(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.65,
                      child: Card(
                        elevation: 8,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: const [
                                    0.1,
                                    0.6,
                                    0.9,
                                  ],
                                  colors: [
                                    Colors.red.shade600,
                                    Colors.red.shade500,
                                    Colors.red.shade400,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: -100,
                              bottom: -100,
                              child: SvgPicture.asset(
                                'assets/icons/BTP.svg',
                                width: 256,
                                height: 256,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white12,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: -64,
                              child: Image.asset(
                                'assets/icon.png',
                                width: 256,
                                height: 256,
                                color: Colors.white12,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.type
                                            .langName(context)
                                            .toUpperCase(),
                                        style: GoogleFonts.ubuntu(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        _displayNumber,
                                        style: GoogleFonts.ubuntu(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            const Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 3,
                                              color: Colors.black54,
                                            ),
                                            Shadow(
                                              offset: const Offset(-2, -2),
                                              blurRadius: 3,
                                              color: Colors.white.withValues(
                                                alpha: 0.7,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.lang?.titularName
                                                      .toUpperCase() ??
                                                  '{{titularName}}',
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              _titularName?.toUpperCase() ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.ubuntu(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                shadows: [
                                                  const Shadow(
                                                    offset: Offset(2, 2),
                                                    blurRadius: 3,
                                                    color: Colors.black54,
                                                  ),
                                                  Shadow(
                                                    offset:
                                                        const Offset(-2, -2),
                                                    blurRadius: 3,
                                                    color:
                                                        Colors.white.withValues(
                                                      alpha: 0.7,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.lang?.expirationDate
                                                      .toUpperCase() ??
                                                  '{{expirationDate}}',
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              _expirationDate,
                                              style: GoogleFonts.ubuntu(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                shadows: [
                                                  const Shadow(
                                                    offset: Offset(2, 2),
                                                    blurRadius: 3,
                                                    color: Colors.black54,
                                                  ),
                                                  Shadow(
                                                    offset:
                                                        const Offset(-2, -2),
                                                    blurRadius: 3,
                                                    color:
                                                        Colors.white.withValues(
                                                      alpha: 0.7,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: context.lang?.titularName,
                    ),
                    validator: ValidationBuilder(
                      requiredMessage: context.lang?.thisFieldIsRequired,
                    ).build(),
                    onChanged: (value) {
                      setState(() {
                        _titularName = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 8,
                        child: TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: context.lang?.cardNumber,
                          ),
                          validator: ValidationBuilder(
                            requiredMessage: context.lang?.thisFieldIsRequired,
                          ).build(),
                          maxLength: 16,
                          buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) {
                            return Container();
                          },
                          onChanged: _updateText,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.225 - 8,
                        child: FocusScope(
                          onFocusChange: (_) {
                            final month =
                                _expirationController.text.split('/')[0];
                            final year =
                                _expirationController.text.split('/')[1];
                            _expirationController.text =
                                '${int.parse(month) == 0 ? '01' : int.parse(month) > 12 ? '12' : month}'
                                '/${int.parse(year) < (DateTime.now().year % 100) ? DateTime.now().add(const Duration(days: 790)).year % 100 : year}';
                            setState(() {
                              _expirationDate = _expirationController.text;
                            });
                          },
                          child: TextFormField(
                            controller: _expirationController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: context.lang?.expirationDate,
                            ),
                            maxLength: 5,
                            validator: ValidationBuilder(
                              requiredMessage:
                                  context.lang?.thisFieldIsRequired,
                            ).build(),
                            onEditingComplete: () {
                              final month =
                                  _expirationController.text.split('/')[0];
                              final year =
                                  _expirationController.text.split('/')[1];
                              _expirationController.text =
                                  '${int.parse(month) == 0 ? '01' : int.parse(month) > 12 ? '12' : month}'
                                  '/${int.parse(year) < (DateTime.now().year % 100) ? DateTime.now().add(const Duration(days: 790)).year % 100 : year}';
                              setState(() {
                                _expirationDate = _expirationController.text;
                              });
                            },
                            buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) {
                              return Container();
                            },
                            onChanged: (value) {
                              setState(() {
                                _expirationDate = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          controller: _cvcController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'CVC',
                          ),
                          validator: ValidationBuilder(
                            requiredMessage: context.lang?.thisFieldIsRequired,
                          ).build(),
                          maxLength: 3,
                          buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) {
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: FilledButton(
          onPressed: !_acceptedTerms
              ? null
              : _loadingSave
                  ? () {}
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loadingSave = true;
                        });
                        try {
                          final expirationDate =
                              _expirationController.text.split('/');
                          final month = expirationDate.first;
                          final year = expirationDate.last;
                          await paymentsNotifier.addMethod(
                            number: _numberController.text,
                            cvc: _cvcController.text,
                            expMonth: month,
                            expYear: year,
                            cardHolder: _nameController.text,
                          );
                          if (context.mounted) {
                            context.pop(true);
                          }
                          return;
                        } catch (error, _) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$error'),
                              ),
                            );
                          }
                        }
                      }
                      setState(() {
                        _loadingSave = false;
                      });
                    },
          child: _loadingSave
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  context.lang?.saveChanges ?? '{{saveChanges}}',
                ),
        ),
      ),
    );
  }
}
