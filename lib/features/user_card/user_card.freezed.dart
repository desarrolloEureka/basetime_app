// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserCard _$UserCardFromJson(Map<String, dynamic> json) {
  return _UserCard.fromJson(json);
}

/// @nodoc
mixin _$UserCard {
  String get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get showPrice => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get categoriesIcons => throw _privateConstructorUsedError;
  List<String> get likes => throw _privateConstructorUsedError;
  List<String> get wishlists => throw _privateConstructorUsedError;

  /// Serializes this UserCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCardCopyWith<UserCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCardCopyWith<$Res> {
  factory $UserCardCopyWith(UserCard value, $Res Function(UserCard) then) =
      _$UserCardCopyWithImpl<$Res, UserCard>;
  @useResult
  $Res call(
      {String id,
      String image,
      double price,
      String showPrice,
      String description,
      List<String> categoriesIcons,
      List<String> likes,
      List<String> wishlists});
}

/// @nodoc
class _$UserCardCopyWithImpl<$Res, $Val extends UserCard>
    implements $UserCardCopyWith<$Res> {
  _$UserCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? price = null,
    Object? showPrice = null,
    Object? description = null,
    Object? categoriesIcons = null,
    Object? likes = null,
    Object? wishlists = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      showPrice: null == showPrice
          ? _value.showPrice
          : showPrice // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      categoriesIcons: null == categoriesIcons
          ? _value.categoriesIcons
          : categoriesIcons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wishlists: null == wishlists
          ? _value.wishlists
          : wishlists // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCardImplCopyWith<$Res>
    implements $UserCardCopyWith<$Res> {
  factory _$$UserCardImplCopyWith(
          _$UserCardImpl value, $Res Function(_$UserCardImpl) then) =
      __$$UserCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String image,
      double price,
      String showPrice,
      String description,
      List<String> categoriesIcons,
      List<String> likes,
      List<String> wishlists});
}

/// @nodoc
class __$$UserCardImplCopyWithImpl<$Res>
    extends _$UserCardCopyWithImpl<$Res, _$UserCardImpl>
    implements _$$UserCardImplCopyWith<$Res> {
  __$$UserCardImplCopyWithImpl(
      _$UserCardImpl _value, $Res Function(_$UserCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? price = null,
    Object? showPrice = null,
    Object? description = null,
    Object? categoriesIcons = null,
    Object? likes = null,
    Object? wishlists = null,
  }) {
    return _then(_$UserCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      showPrice: null == showPrice
          ? _value.showPrice
          : showPrice // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      categoriesIcons: null == categoriesIcons
          ? _value._categoriesIcons
          : categoriesIcons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wishlists: null == wishlists
          ? _value._wishlists
          : wishlists // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCardImpl implements _UserCard {
  _$UserCardImpl(
      {required this.id,
      required this.image,
      required this.price,
      required this.showPrice,
      required this.description,
      required final List<String> categoriesIcons,
      required final List<String> likes,
      required final List<String> wishlists})
      : _categoriesIcons = categoriesIcons,
        _likes = likes,
        _wishlists = wishlists;

  factory _$UserCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCardImplFromJson(json);

  @override
  final String id;
  @override
  final String image;
  @override
  final double price;
  @override
  final String showPrice;
  @override
  final String description;
  final List<String> _categoriesIcons;
  @override
  List<String> get categoriesIcons {
    if (_categoriesIcons is EqualUnmodifiableListView) return _categoriesIcons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoriesIcons);
  }

  final List<String> _likes;
  @override
  List<String> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  final List<String> _wishlists;
  @override
  List<String> get wishlists {
    if (_wishlists is EqualUnmodifiableListView) return _wishlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wishlists);
  }

  @override
  String toString() {
    return 'UserCard(id: $id, image: $image, price: $price, showPrice: $showPrice, description: $description, categoriesIcons: $categoriesIcons, likes: $likes, wishlists: $wishlists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.showPrice, showPrice) ||
                other.showPrice == showPrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._categoriesIcons, _categoriesIcons) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            const DeepCollectionEquality()
                .equals(other._wishlists, _wishlists));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      image,
      price,
      showPrice,
      description,
      const DeepCollectionEquality().hash(_categoriesIcons),
      const DeepCollectionEquality().hash(_likes),
      const DeepCollectionEquality().hash(_wishlists));

  /// Create a copy of UserCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCardImplCopyWith<_$UserCardImpl> get copyWith =>
      __$$UserCardImplCopyWithImpl<_$UserCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCardImplToJson(
      this,
    );
  }
}

abstract class _UserCard implements UserCard {
  factory _UserCard(
      {required final String id,
      required final String image,
      required final double price,
      required final String showPrice,
      required final String description,
      required final List<String> categoriesIcons,
      required final List<String> likes,
      required final List<String> wishlists}) = _$UserCardImpl;

  factory _UserCard.fromJson(Map<String, dynamic> json) =
      _$UserCardImpl.fromJson;

  @override
  String get id;
  @override
  String get image;
  @override
  double get price;
  @override
  String get showPrice;
  @override
  String get description;
  @override
  List<String> get categoriesIcons;
  @override
  List<String> get likes;
  @override
  List<String> get wishlists;

  /// Create a copy of UserCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCardImplCopyWith<_$UserCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
