import 'package:intl/intl.dart';

class Currency {
  Currency({required this.amount});
  final num amount;

  String get cop => '\$${NumberFormat.currency(
        locale: 'es-ES',
        name: 'COP',
        decimalDigits: 2,
      ).format(amount)}';
}
