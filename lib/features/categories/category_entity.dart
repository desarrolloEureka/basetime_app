import 'package:basetime/core/context/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  factory CategoryEntity({
    required String id,
    required String nameEs,
    required String nameEn,
    required String descriptionEs,
    required String descriptionEn,
    required bool isActive,
    required int icon,
    CategoryEntity? parent,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);
}

extension CategoryExtension on CategoryEntity {
  String langName(BuildContext context) {
    return context.lang?.localeName == 'en' ? nameEn : nameEs;
  }

  String langDescription(BuildContext context) {
    return context.lang?.localeName == 'en' ? descriptionEn : descriptionEs;
  }
}
