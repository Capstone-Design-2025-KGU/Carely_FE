// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}

/// @nodoc
mixin _$Member {
  int get memberId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get birth => throw _privateConstructorUsedError;
  String? get story => throw _privateConstructorUsedError;
  MemberType get memberType => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  Skill get skill => throw _privateConstructorUsedError;

  /// Serializes this Member to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res, Member>;
  @useResult
  $Res call({
    int memberId,
    String username,
    String name,
    String phoneNumber,
    String birth,
    String? story,
    MemberType memberType,
    bool isVisible,
    bool isVerified,
    String? profileImage,
    DateTime? createdAt,
    Address address,
    Skill skill,
  });

  $AddressCopyWith<$Res> get address;
  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class _$MemberCopyWithImpl<$Res, $Val extends Member>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? username = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? birth = null,
    Object? story = freezed,
    Object? memberType = null,
    Object? isVisible = null,
    Object? isVerified = null,
    Object? profileImage = freezed,
    Object? createdAt = freezed,
    Object? address = null,
    Object? skill = null,
  }) {
    return _then(
      _value.copyWith(
            memberId:
                null == memberId
                    ? _value.memberId
                    : memberId // ignore: cast_nullable_to_non_nullable
                        as int,
            username:
                null == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            birth:
                null == birth
                    ? _value.birth
                    : birth // ignore: cast_nullable_to_non_nullable
                        as String,
            story:
                freezed == story
                    ? _value.story
                    : story // ignore: cast_nullable_to_non_nullable
                        as String?,
            memberType:
                null == memberType
                    ? _value.memberType
                    : memberType // ignore: cast_nullable_to_non_nullable
                        as MemberType,
            isVisible:
                null == isVisible
                    ? _value.isVisible
                    : isVisible // ignore: cast_nullable_to_non_nullable
                        as bool,
            isVerified:
                null == isVerified
                    ? _value.isVerified
                    : isVerified // ignore: cast_nullable_to_non_nullable
                        as bool,
            profileImage:
                freezed == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as Address,
            skill:
                null == skill
                    ? _value.skill
                    : skill // ignore: cast_nullable_to_non_nullable
                        as Skill,
          )
          as $Val,
    );
  }

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get skill {
    return $SkillCopyWith<$Res>(_value.skill, (value) {
      return _then(_value.copyWith(skill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemberImplCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$$MemberImplCopyWith(
    _$MemberImpl value,
    $Res Function(_$MemberImpl) then,
  ) = __$$MemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memberId,
    String username,
    String name,
    String phoneNumber,
    String birth,
    String? story,
    MemberType memberType,
    bool isVisible,
    bool isVerified,
    String? profileImage,
    DateTime? createdAt,
    Address address,
    Skill skill,
  });

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class __$$MemberImplCopyWithImpl<$Res>
    extends _$MemberCopyWithImpl<$Res, _$MemberImpl>
    implements _$$MemberImplCopyWith<$Res> {
  __$$MemberImplCopyWithImpl(
    _$MemberImpl _value,
    $Res Function(_$MemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? username = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? birth = null,
    Object? story = freezed,
    Object? memberType = null,
    Object? isVisible = null,
    Object? isVerified = null,
    Object? profileImage = freezed,
    Object? createdAt = freezed,
    Object? address = null,
    Object? skill = null,
  }) {
    return _then(
      _$MemberImpl(
        memberId:
            null == memberId
                ? _value.memberId
                : memberId // ignore: cast_nullable_to_non_nullable
                    as int,
        username:
            null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        birth:
            null == birth
                ? _value.birth
                : birth // ignore: cast_nullable_to_non_nullable
                    as String,
        story:
            freezed == story
                ? _value.story
                : story // ignore: cast_nullable_to_non_nullable
                    as String?,
        memberType:
            null == memberType
                ? _value.memberType
                : memberType // ignore: cast_nullable_to_non_nullable
                    as MemberType,
        isVisible:
            null == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                    as bool,
        isVerified:
            null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                    as bool,
        profileImage:
            freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Address,
        skill:
            null == skill
                ? _value.skill
                : skill // ignore: cast_nullable_to_non_nullable
                    as Skill,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MemberImpl implements _Member {
  const _$MemberImpl({
    required this.memberId,
    required this.username,
    required this.name,
    required this.phoneNumber,
    required this.birth,
    this.story,
    required this.memberType,
    required this.isVisible,
    required this.isVerified,
    this.profileImage,
    this.createdAt,
    required this.address,
    required this.skill,
  });

  factory _$MemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberImplFromJson(json);

  @override
  final int memberId;
  @override
  final String username;
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final String birth;
  @override
  final String? story;
  @override
  final MemberType memberType;
  @override
  final bool isVisible;
  @override
  final bool isVerified;
  @override
  final String? profileImage;
  @override
  final DateTime? createdAt;
  @override
  final Address address;
  @override
  final Skill skill;

  @override
  String toString() {
    return 'Member(memberId: $memberId, username: $username, name: $name, phoneNumber: $phoneNumber, birth: $birth, story: $story, memberType: $memberType, isVisible: $isVisible, isVerified: $isVerified, profileImage: $profileImage, createdAt: $createdAt, address: $address, skill: $skill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.story, story) || other.story == story) &&
            (identical(other.memberType, memberType) ||
                other.memberType == memberType) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.skill, skill) || other.skill == skill));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memberId,
    username,
    name,
    phoneNumber,
    birth,
    story,
    memberType,
    isVisible,
    isVerified,
    profileImage,
    createdAt,
    address,
    skill,
  );

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      __$$MemberImplCopyWithImpl<_$MemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberImplToJson(this);
  }
}

abstract class _Member implements Member {
  const factory _Member({
    required final int memberId,
    required final String username,
    required final String name,
    required final String phoneNumber,
    required final String birth,
    final String? story,
    required final MemberType memberType,
    required final bool isVisible,
    required final bool isVerified,
    final String? profileImage,
    final DateTime? createdAt,
    required final Address address,
    required final Skill skill,
  }) = _$MemberImpl;

  factory _Member.fromJson(Map<String, dynamic> json) = _$MemberImpl.fromJson;

  @override
  int get memberId;
  @override
  String get username;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String get birth;
  @override
  String? get story;
  @override
  MemberType get memberType;
  @override
  bool get isVisible;
  @override
  bool get isVerified;
  @override
  String? get profileImage;
  @override
  DateTime? get createdAt;
  @override
  Address get address;
  @override
  Skill get skill;

  /// Create a copy of Member
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberImplCopyWith<_$MemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
