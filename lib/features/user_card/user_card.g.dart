// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCardImpl _$$UserCardImplFromJson(Map<String, dynamic> json) =>
    _$UserCardImpl(
      id: json['id'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      showPrice: json['showPrice'] as String,
      description: json['description'] as String,
      categoriesIcons: (json['categoriesIcons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      wishlists:
          (json['wishlists'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UserCardImplToJson(_$UserCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'price': instance.price,
      'showPrice': instance.showPrice,
      'description': instance.description,
      'categoriesIcons': instance.categoriesIcons,
      'likes': instance.likes,
      'wishlists': instance.wishlists,
    };
