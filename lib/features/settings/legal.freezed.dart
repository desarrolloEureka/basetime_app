// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Legal _$LegalFromJson(Map<String, dynamic> json) {
  return _Legal.fromJson(json);
}

/// @nodoc
mixin _$Legal {
  String? get policyURL => throw _privateConstructorUsedError;
  String? get termsURL => throw _privateConstructorUsedError;

  /// Serializes this Legal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Legal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LegalCopyWith<Legal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LegalCopyWith<$Res> {
  factory $LegalCopyWith(Legal value, $Res Function(Legal) then) =
      _$LegalCopyWithImpl<$Res, Legal>;
  @useResult
  $Res call({String? policyURL, String? termsURL});
}

/// @nodoc
class _$LegalCopyWithImpl<$Res, $Val extends Legal>
    implements $LegalCopyWith<$Res> {
  _$LegalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Legal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? policyURL = freezed,
    Object? termsURL = freezed,
  }) {
    return _then(_value.copyWith(
      policyURL: freezed == policyURL
          ? _value.policyURL
          : policyURL // ignore: cast_nullable_to_non_nullable
              as String?,
      termsURL: freezed == termsURL
          ? _value.termsURL
          : termsURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LegalImplCopyWith<$Res> implements $LegalCopyWith<$Res> {
  factory _$$LegalImplCopyWith(
          _$LegalImpl value, $Res Function(_$LegalImpl) then) =
      __$$LegalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? policyURL, String? termsURL});
}

/// @nodoc
class __$$LegalImplCopyWithImpl<$Res>
    extends _$LegalCopyWithImpl<$Res, _$LegalImpl>
    implements _$$LegalImplCopyWith<$Res> {
  __$$LegalImplCopyWithImpl(
      _$LegalImpl _value, $Res Function(_$LegalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Legal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? policyURL = freezed,
    Object? termsURL = freezed,
  }) {
    return _then(_$LegalImpl(
      policyURL: freezed == policyURL
          ? _value.policyURL
          : policyURL // ignore: cast_nullable_to_non_nullable
              as String?,
      termsURL: freezed == termsURL
          ? _value.termsURL
          : termsURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LegalImpl implements _Legal {
  _$LegalImpl({this.policyURL, this.termsURL});

  factory _$LegalImpl.fromJson(Map<String, dynamic> json) =>
      _$$LegalImplFromJson(json);

  @override
  final String? policyURL;
  @override
  final String? termsURL;

  @override
  String toString() {
    return 'Legal(policyURL: $policyURL, termsURL: $termsURL)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LegalImpl &&
            (identical(other.policyURL, policyURL) ||
                other.policyURL == policyURL) &&
            (identical(other.termsURL, termsURL) ||
                other.termsURL == termsURL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, policyURL, termsURL);

  /// Create a copy of Legal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LegalImplCopyWith<_$LegalImpl> get copyWith =>
      __$$LegalImplCopyWithImpl<_$LegalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LegalImplToJson(
      this,
    );
  }
}

abstract class _Legal implements Legal {
  factory _Legal({final String? policyURL, final String? termsURL}) =
      _$LegalImpl;

  factory _Legal.fromJson(Map<String, dynamic> json) = _$LegalImpl.fromJson;

  @override
  String? get policyURL;
  @override
  String? get termsURL;

  /// Create a copy of Legal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LegalImplCopyWith<_$LegalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
