// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapMember _$MapMemberFromJson(Map<String, dynamic> json) {
  return _MapMember.fromJson(json);
}

/// @nodoc
mixin _$MapMember {
  int get memberId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _birthFromJson)
  String get birth => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String? get story => throw _privateConstructorUsedError;
  @MemberTypeConverter()
  MemberType get memberType => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  int get withTime => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  Skill? get skill => throw _privateConstructorUsedError;

  /// Serializes this MapMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapMemberCopyWith<MapMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapMemberCopyWith<$Res> {
  factory $MapMemberCopyWith(MapMember value, $Res Function(MapMember) then) =
      _$MapMemberCopyWithImpl<$Res, MapMember>;
  @useResult
  $Res call({
    int memberId,
    String username,
    String name,
    @JsonKey(fromJson: _birthFromJson) String birth,
    int age,
    String? story,
    @MemberTypeConverter() MemberType memberType,
    String? profileImage,
    double distance,
    int withTime,
    Address? address,
    Skill? skill,
  });

  $AddressCopyWith<$Res>? get address;
  $SkillCopyWith<$Res>? get skill;
}

/// @nodoc
class _$MapMemberCopyWithImpl<$Res, $Val extends MapMember>
    implements $MapMemberCopyWith<$Res> {
  _$MapMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? username = null,
    Object? name = null,
    Object? birth = null,
    Object? age = null,
    Object? story = freezed,
    Object? memberType = null,
    Object? profileImage = freezed,
    Object? distance = null,
    Object? withTime = null,
    Object? address = freezed,
    Object? skill = freezed,
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
            birth:
                null == birth
                    ? _value.birth
                    : birth // ignore: cast_nullable_to_non_nullable
                        as String,
            age:
                null == age
                    ? _value.age
                    : age // ignore: cast_nullable_to_non_nullable
                        as int,
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
            profileImage:
                freezed == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            distance:
                null == distance
                    ? _value.distance
                    : distance // ignore: cast_nullable_to_non_nullable
                        as double,
            withTime:
                null == withTime
                    ? _value.withTime
                    : withTime // ignore: cast_nullable_to_non_nullable
                        as int,
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as Address?,
            skill:
                freezed == skill
                    ? _value.skill
                    : skill // ignore: cast_nullable_to_non_nullable
                        as Skill?,
          )
          as $Val,
    );
  }

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get skill {
    if (_value.skill == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.skill!, (value) {
      return _then(_value.copyWith(skill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MapMemberImplCopyWith<$Res>
    implements $MapMemberCopyWith<$Res> {
  factory _$$MapMemberImplCopyWith(
    _$MapMemberImpl value,
    $Res Function(_$MapMemberImpl) then,
  ) = __$$MapMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memberId,
    String username,
    String name,
    @JsonKey(fromJson: _birthFromJson) String birth,
    int age,
    String? story,
    @MemberTypeConverter() MemberType memberType,
    String? profileImage,
    double distance,
    int withTime,
    Address? address,
    Skill? skill,
  });

  @override
  $AddressCopyWith<$Res>? get address;
  @override
  $SkillCopyWith<$Res>? get skill;
}

/// @nodoc
class __$$MapMemberImplCopyWithImpl<$Res>
    extends _$MapMemberCopyWithImpl<$Res, _$MapMemberImpl>
    implements _$$MapMemberImplCopyWith<$Res> {
  __$$MapMemberImplCopyWithImpl(
    _$MapMemberImpl _value,
    $Res Function(_$MapMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? username = null,
    Object? name = null,
    Object? birth = null,
    Object? age = null,
    Object? story = freezed,
    Object? memberType = null,
    Object? profileImage = freezed,
    Object? distance = null,
    Object? withTime = null,
    Object? address = freezed,
    Object? skill = freezed,
  }) {
    return _then(
      _$MapMemberImpl(
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
        birth:
            null == birth
                ? _value.birth
                : birth // ignore: cast_nullable_to_non_nullable
                    as String,
        age:
            null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                    as int,
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
        profileImage:
            freezed == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        distance:
            null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                    as double,
        withTime:
            null == withTime
                ? _value.withTime
                : withTime // ignore: cast_nullable_to_non_nullable
                    as int,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Address?,
        skill:
            freezed == skill
                ? _value.skill
                : skill // ignore: cast_nullable_to_non_nullable
                    as Skill?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MapMemberImpl implements _MapMember {
  const _$MapMemberImpl({
    required this.memberId,
    required this.username,
    required this.name,
    @JsonKey(fromJson: _birthFromJson) required this.birth,
    required this.age,
    this.story,
    @MemberTypeConverter() required this.memberType,
    this.profileImage,
    required this.distance,
    required this.withTime,
    this.address,
    this.skill,
  });

  factory _$MapMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapMemberImplFromJson(json);

  @override
  final int memberId;
  @override
  final String username;
  @override
  final String name;
  @override
  @JsonKey(fromJson: _birthFromJson)
  final String birth;
  @override
  final int age;
  @override
  final String? story;
  @override
  @MemberTypeConverter()
  final MemberType memberType;
  @override
  final String? profileImage;
  @override
  final double distance;
  @override
  final int withTime;
  @override
  final Address? address;
  @override
  final Skill? skill;

  @override
  String toString() {
    return 'MapMember(memberId: $memberId, username: $username, name: $name, birth: $birth, age: $age, story: $story, memberType: $memberType, profileImage: $profileImage, distance: $distance, withTime: $withTime, address: $address, skill: $skill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapMemberImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birth, birth) || other.birth == birth) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.story, story) || other.story == story) &&
            (identical(other.memberType, memberType) ||
                other.memberType == memberType) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.withTime, withTime) ||
                other.withTime == withTime) &&
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
    birth,
    age,
    story,
    memberType,
    profileImage,
    distance,
    withTime,
    address,
    skill,
  );

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapMemberImplCopyWith<_$MapMemberImpl> get copyWith =>
      __$$MapMemberImplCopyWithImpl<_$MapMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapMemberImplToJson(this);
  }
}

abstract class _MapMember implements MapMember {
  const factory _MapMember({
    required final int memberId,
    required final String username,
    required final String name,
    @JsonKey(fromJson: _birthFromJson) required final String birth,
    required final int age,
    final String? story,
    @MemberTypeConverter() required final MemberType memberType,
    final String? profileImage,
    required final double distance,
    required final int withTime,
    final Address? address,
    final Skill? skill,
  }) = _$MapMemberImpl;

  factory _MapMember.fromJson(Map<String, dynamic> json) =
      _$MapMemberImpl.fromJson;

  @override
  int get memberId;
  @override
  String get username;
  @override
  String get name;
  @override
  @JsonKey(fromJson: _birthFromJson)
  String get birth;
  @override
  int get age;
  @override
  String? get story;
  @override
  @MemberTypeConverter()
  MemberType get memberType;
  @override
  String? get profileImage;
  @override
  double get distance;
  @override
  int get withTime;
  @override
  Address? get address;
  @override
  Skill? get skill;

  /// Create a copy of MapMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapMemberImplCopyWith<_$MapMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
