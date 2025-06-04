import 'package:freezed_annotation/freezed_annotation.dart';

part 'legal.freezed.dart';
part 'legal.g.dart';

@freezed
class Legal with _$Legal {
  factory Legal({
    String? policyURL,
    String? termsURL,
  }) = _Legal;

  factory Legal.fromJson(Map<String, dynamic> json) => _$LegalFromJson(json);
}
