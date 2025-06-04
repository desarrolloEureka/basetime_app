import 'package:form_validator/form_validator.dart';

/// Validations extension
extension ValidationsExtensions on ValidationBuilder {
  /// Password
  ValidationBuilder password([String? message]) {
    return add((value) {
      if (value == 'password' || value == 'contraseña') {
        return message;
      }
      return null;
    });
  }

  /// Is same
  ValidationBuilder isSame([String? message, String? compare]) {
    return add((value) {
      if (value?.trim() != compare?.trim()) {
        return message;
      }
      return null;
    });
  }
}
