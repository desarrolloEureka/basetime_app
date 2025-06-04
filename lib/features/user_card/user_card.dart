import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_card.freezed.dart';
part 'user_card.g.dart';

@freezed
class UserCard with _$UserCard {
  factory UserCard({
    required String id,
    required String image,
    required double price,
    required String showPrice,
    required String description,
    required List<String> categoriesIcons,
    required List<String> likes,
    required List<String> wishlists,
  }) = _UserCard;

  factory UserCard.fromJson(Map<String, dynamic> json) =>
      _$UserCardFromJson(json);
}
