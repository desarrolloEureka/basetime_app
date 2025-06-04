// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommissionsImpl _$$CommissionsImplFromJson(Map<String, dynamic> json) =>
    _$CommissionsImpl(
      basetime: (json['basetime'] as num).toInt(),
      referrals: (json['referrals'] as num).toInt(),
      wompi: (json['wompi'] as num).toInt(),
    );

Map<String, dynamic> _$$CommissionsImplToJson(_$CommissionsImpl instance) =>
    <String, dynamic>{
      'basetime': instance.basetime,
      'referrals': instance.referrals,
      'wompi': instance.wompi,
    };
