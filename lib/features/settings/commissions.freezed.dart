// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commissions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Commissions _$CommissionsFromJson(Map<String, dynamic> json) {
  return _Commissions.fromJson(json);
}

/// @nodoc
mixin _$Commissions {
  int get basetime => throw _privateConstructorUsedError;
  int get referrals => throw _privateConstructorUsedError;
  int get wompi => throw _privateConstructorUsedError;

  /// Serializes this Commissions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Commissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommissionsCopyWith<Commissions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommissionsCopyWith<$Res> {
  factory $CommissionsCopyWith(
          Commissions value, $Res Function(Commissions) then) =
      _$CommissionsCopyWithImpl<$Res, Commissions>;
  @useResult
  $Res call({int basetime, int referrals, int wompi});
}

/// @nodoc
class _$CommissionsCopyWithImpl<$Res, $Val extends Commissions>
    implements $CommissionsCopyWith<$Res> {
  _$CommissionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Commissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basetime = null,
    Object? referrals = null,
    Object? wompi = null,
  }) {
    return _then(_value.copyWith(
      basetime: null == basetime
          ? _value.basetime
          : basetime // ignore: cast_nullable_to_non_nullable
              as int,
      referrals: null == referrals
          ? _value.referrals
          : referrals // ignore: cast_nullable_to_non_nullable
              as int,
      wompi: null == wompi
          ? _value.wompi
          : wompi // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommissionsImplCopyWith<$Res>
    implements $CommissionsCopyWith<$Res> {
  factory _$$CommissionsImplCopyWith(
          _$CommissionsImpl value, $Res Function(_$CommissionsImpl) then) =
      __$$CommissionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int basetime, int referrals, int wompi});
}

/// @nodoc
class __$$CommissionsImplCopyWithImpl<$Res>
    extends _$CommissionsCopyWithImpl<$Res, _$CommissionsImpl>
    implements _$$CommissionsImplCopyWith<$Res> {
  __$$CommissionsImplCopyWithImpl(
      _$CommissionsImpl _value, $Res Function(_$CommissionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Commissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basetime = null,
    Object? referrals = null,
    Object? wompi = null,
  }) {
    return _then(_$CommissionsImpl(
      basetime: null == basetime
          ? _value.basetime
          : basetime // ignore: cast_nullable_to_non_nullable
              as int,
      referrals: null == referrals
          ? _value.referrals
          : referrals // ignore: cast_nullable_to_non_nullable
              as int,
      wompi: null == wompi
          ? _value.wompi
          : wompi // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommissionsImpl implements _Commissions {
  _$CommissionsImpl(
      {required this.basetime, required this.referrals, required this.wompi});

  factory _$CommissionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommissionsImplFromJson(json);

  @override
  final int basetime;
  @override
  final int referrals;
  @override
  final int wompi;

  @override
  String toString() {
    return 'Commissions(basetime: $basetime, referrals: $referrals, wompi: $wompi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommissionsImpl &&
            (identical(other.basetime, basetime) ||
                other.basetime == basetime) &&
            (identical(other.referrals, referrals) ||
                other.referrals == referrals) &&
            (identical(other.wompi, wompi) || other.wompi == wompi));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basetime, referrals, wompi);

  /// Create a copy of Commissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommissionsImplCopyWith<_$CommissionsImpl> get copyWith =>
      __$$CommissionsImplCopyWithImpl<_$CommissionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommissionsImplToJson(
      this,
    );
  }
}

abstract class _Commissions implements Commissions {
  factory _Commissions(
      {required final int basetime,
      required final int referrals,
      required final int wompi}) = _$CommissionsImpl;

  factory _Commissions.fromJson(Map<String, dynamic> json) =
      _$CommissionsImpl.fromJson;

  @override
  int get basetime;
  @override
  int get referrals;
  @override
  int get wompi;

  /// Create a copy of Commissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommissionsImplCopyWith<_$CommissionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
