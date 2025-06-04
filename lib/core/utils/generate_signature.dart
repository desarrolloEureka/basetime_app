import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateSignatureWompi(
  String referencia,
  String monto,
  String moneda,
  String secretoIntegridad,
) {
  final combined = '$referencia$monto$moneda$secretoIntegridad';
  final bytes = utf8.encode(combined);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
