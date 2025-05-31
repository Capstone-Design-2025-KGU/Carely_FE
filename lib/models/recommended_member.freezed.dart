// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecommendedMember _$RecommendedMemberFromJson(Map<String, dynamic> json) {
  return _RecommendedMember.fromJson(json);
}

/// @nodoc
mixin _$RecommendedMember {
  int get memberId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  @MemberTypeConverter()
  MemberType get memberType => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  int? get withTime => throw _privateConstructorUsedError;

  /// Serializes this RecommendedMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedMemberCopyWith<RecommendedMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedMemberCopyWith<$Res> {
  factory $RecommendedMemberCopyWith(
    RecommendedMember value,
    $Res Function(RecommendedMember) then,
  ) = _$RecommendedMemberCopyWithImpl<$Res, RecommendedMember>;
  @useResult
  $Res call({
    int memberId,
    String name,
    String? profileImage,
    @MemberTypeConverter() MemberType memberType,
    double distance,
    int? withTime,
  });
}

/// @nodoc
class _$RecommendedMemberCopyWithImpl<$Res, $Val extends RecommendedMember>
    implements $RecommendedMemberCopyWith<$Res> {
  _$RecommendedMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? name = null,
    Object? profileImage = freezed,
    Object? memberType = null,
    Object? distance = null,
    Object? withTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            memberId:
                null == memberId
                    ? _value.memberId
                    : memberId // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            profileImage:
                freezed == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            memberType:
                null == memberType
                    ? _value.memberType
                    : memberType // ignore: cast_nullable_to_non_nullable
                        as MemberType,
            distance:
                null == distance
                    ? _value.distance
                    : distance // ignore: cast_nullable_to_non_nullable
                        as double,
            withTime:
                freezed == withTime
                    ? _value.withTime
                    : withTime // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendedMemberImplCopyWith<$Res>
    implements $RecommendedMemberCopyWith<$Res> {
  factory _$$RecommendedMemberImplCopyWith(
    _$RecommendedMemberImpl value,
    $Res Function(_$RecommendedMemberImpl) then,
  ) = __$$RecommendedMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memberId,
    String name,
    String? profileImage,
    @MemberTypeConverter() MemberType memberType,
    double distance,
    int? withTime,
  });
}

/// @nodoc
class __$$RecommendedMemberImplCopyWithImpl<$Res>
    extends _$RecommendedMemberCopyWithImpl<$Res, _$RecommendedMemberImpl>
    implements _$$RecommendedMemberImplCopyWith<$Res> {
  __$$RecommendedMemberImplCopyWithImpl(
    _$RecommendedMemberImpl _value,
    $Res Function(_$RecommendedMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendedMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? name = null,
    Object? profileImage = freezed,
    Object? memberType = null,
    Object? distance = null,
    Object? withTime = freezed,
  }) {
    return _then(
      _$RecommendedMemberImpl(
        memberId:
            null == memberId
                ? _value.memberId
                : memberId // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        profileImage:
            freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        memberType:
            null == memberType
                ? _value.memberType
                : memberType // ignore: cast_nullable_to_non_nullable
                    as MemberType,
        distance:
            null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                    as double,
        withTime:
            freezed == withTime
                ? _value.withTime
                : withTime // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendedMemberImpl implements _RecommendedMember {
  const _$RecommendedMemberImpl({
    required this.memberId,
    required this.name,
    this.profileImage,
    @MemberTypeConverter() required this.memberType,
    required this.distance,
    this.withTime,
  });

  factory _$RecommendedMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendedMemberImplFromJson(json);

  @override
  final int memberId;
  @override
  final String name;
  @override
  final String? profileImage;
  @override
  @MemberTypeConverter()
  final MemberType memberType;
  @override
  final double distance;
  @override
  final int? withTime;

  @override
  String toString() {
    return 'RecommendedMember(memberId: $memberId, name: $name, profileImage: $profileImage, memberType: $memberType, distance: $distance, withTime: $withTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedMemberImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.memberType, memberType) ||
                other.memberType == memberType) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.withTime, withTime) ||
                other.withTime == withTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memberId,
    name,
    profileImage,
    memberType,
    distance,
    withTime,
  );

  /// Create a copy of RecommendedMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedMemberImplCopyWith<_$RecommendedMemberImpl> get copyWith =>
      __$$RecommendedMemberImplCopyWithImpl<_$RecommendedMemberImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendedMemberImplToJson(this);
  }
}

abstract class _RecommendedMember implements RecommendedMember {
  const factory _RecommendedMember({
    required final int memberId,
    required final String name,
    final String? profileImage,
    @MemberTypeConverter() required final MemberType memberType,
    required final double distance,
    final int? withTime,
  }) = _$RecommendedMemberImpl;

  factory _RecommendedMember.fromJson(Map<String, dynamic> json) =
      _$RecommendedMemberImpl.fromJson;

  @override
  int get memberId;
  @override
  String get name;
  @override
  String? get profileImage;
  @override
  @MemberTypeConverter()
  MemberType get memberType;
  @override
  double get distance;
  @override
  int? get withTime;

  /// Create a copy of RecommendedMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedMemberImplCopyWith<_$RecommendedMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
