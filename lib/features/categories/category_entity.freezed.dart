// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) {
  return _CategoryEntity.fromJson(json);
}

/// @nodoc
mixin _$CategoryEntity {
  String get id => throw _privateConstructorUsedError;
  String get nameEs => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get descriptionEs => throw _privateConstructorUsedError;
  String get descriptionEn => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get icon => throw _privateConstructorUsedError;
  CategoryEntity? get parent => throw _privateConstructorUsedError;

  /// Serializes this CategoryEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryEntityCopyWith<CategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEntityCopyWith<$Res> {
  factory $CategoryEntityCopyWith(
          CategoryEntity value, $Res Function(CategoryEntity) then) =
      _$CategoryEntityCopyWithImpl<$Res, CategoryEntity>;
  @useResult
  $Res call(
      {String id,
      String nameEs,
      String nameEn,
      String descriptionEs,
      String descriptionEn,
      bool isActive,
      int icon,
      CategoryEntity? parent});

  $CategoryEntityCopyWith<$Res>? get parent;
}

/// @nodoc
class _$CategoryEntityCopyWithImpl<$Res, $Val extends CategoryEntity>
    implements $CategoryEntityCopyWith<$Res> {
  _$CategoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameEs = null,
    Object? nameEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? isActive = null,
    Object? icon = null,
    Object? parent = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameEs: null == nameEs
          ? _value.nameEs
          : nameEs // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEs: null == descriptionEs
          ? _value.descriptionEs
          : descriptionEs // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEn: null == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
    ) as $Val);
  }

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryEntityCopyWith<$Res>? get parent {
    if (_value.parent == null) {
      return null;
    }

    return $CategoryEntityCopyWith<$Res>(_value.parent!, (value) {
      return _then(_value.copyWith(parent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CategoryEntityImplCopyWith<$Res>
    implements $CategoryEntityCopyWith<$Res> {
  factory _$$CategoryEntityImplCopyWith(_$CategoryEntityImpl value,
          $Res Function(_$CategoryEntityImpl) then) =
      __$$CategoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nameEs,
      String nameEn,
      String descriptionEs,
      String descriptionEn,
      bool isActive,
      int icon,
      CategoryEntity? parent});

  @override
  $CategoryEntityCopyWith<$Res>? get parent;
}

/// @nodoc
class __$$CategoryEntityImplCopyWithImpl<$Res>
    extends _$CategoryEntityCopyWithImpl<$Res, _$CategoryEntityImpl>
    implements _$$CategoryEntityImplCopyWith<$Res> {
  __$$CategoryEntityImplCopyWithImpl(
      _$CategoryEntityImpl _value, $Res Function(_$CategoryEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameEs = null,
    Object? nameEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? isActive = null,
    Object? icon = null,
    Object? parent = freezed,
  }) {
    return _then(_$CategoryEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nameEs: null == nameEs
          ? _value.nameEs
          : nameEs // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEs: null == descriptionEs
          ? _value.descriptionEs
          : descriptionEs // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionEn: null == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryEntityImpl implements _CategoryEntity {
  _$CategoryEntityImpl(
      {required this.id,
      required this.nameEs,
      required this.nameEn,
      required this.descriptionEs,
      required this.descriptionEn,
      required this.isActive,
      required this.icon,
      this.parent});

  factory _$CategoryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String nameEs;
  @override
  final String nameEn;
  @override
  final String descriptionEs;
  @override
  final String descriptionEn;
  @override
  final bool isActive;
  @override
  final int icon;
  @override
  final CategoryEntity? parent;

  @override
  String toString() {
    return 'CategoryEntity(id: $id, nameEs: $nameEs, nameEn: $nameEn, descriptionEs: $descriptionEs, descriptionEn: $descriptionEn, isActive: $isActive, icon: $icon, parent: $parent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameEs, nameEs) || other.nameEs == nameEs) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.descriptionEs, descriptionEs) ||
                other.descriptionEs == descriptionEs) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nameEs, nameEn,
      descriptionEs, descriptionEn, isActive, icon, parent);

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryEntityImplCopyWith<_$CategoryEntityImpl> get copyWith =>
      __$$CategoryEntityImplCopyWithImpl<_$CategoryEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryEntityImplToJson(
      this,
    );
  }
}

abstract class _CategoryEntity implements CategoryEntity {
  factory _CategoryEntity(
      {required final String id,
      required final String nameEs,
      required final String nameEn,
      required final String descriptionEs,
      required final String descriptionEn,
      required final bool isActive,
      required final int icon,
      final CategoryEntity? parent}) = _$CategoryEntityImpl;

  factory _CategoryEntity.fromJson(Map<String, dynamic> json) =
      _$CategoryEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get nameEs;
  @override
  String get nameEn;
  @override
  String get descriptionEs;
  @override
  String get descriptionEn;
  @override
  bool get isActive;
  @override
  int get icon;
  @override
  CategoryEntity? get parent;

  /// Create a copy of CategoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryEntityImplCopyWith<_$CategoryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
