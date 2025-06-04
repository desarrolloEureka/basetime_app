// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryEntityImpl _$$CategoryEntityImplFromJson(Map<String, dynamic> json) =>
    _$CategoryEntityImpl(
      id: json['id'] as String,
      nameEs: json['nameEs'] as String,
      nameEn: json['nameEn'] as String,
      descriptionEs: json['descriptionEs'] as String,
      descriptionEn: json['descriptionEn'] as String,
      isActive: json['isActive'] as bool,
      icon: (json['icon'] as num).toInt(),
      parent: json['parent'] == null
          ? null
          : CategoryEntity.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CategoryEntityImplToJson(
        _$CategoryEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEs': instance.nameEs,
      'nameEn': instance.nameEn,
      'descriptionEs': instance.descriptionEs,
      'descriptionEn': instance.descriptionEn,
      'isActive': instance.isActive,
      'icon': instance.icon,
      'parent': instance.parent,
    };
