import 'package:freezed_annotation/freezed_annotation.dart';

part 'commissions.freezed.dart';
part 'commissions.g.dart';

@freezed
class Commissions with _$Commissions {
  factory Commissions({
    required int basetime,
    required int referrals,
    required int wompi,
  }) = _Commissions;

  factory Commissions.fromJson(Map<String, dynamic> json) =>
      _$CommissionsFromJson(json);
}
