// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  int get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  String? get story => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call({
    int teamId,
    String teamName,
    Address address,
    String? story,
    int memberCount,
  });

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? address = null,
    Object? story = freezed,
    Object? memberCount = null,
  }) {
    return _then(
      _value.copyWith(
            teamId:
                null == teamId
                    ? _value.teamId
                    : teamId // ignore: cast_nullable_to_non_nullable
                        as int,
            teamName:
                null == teamName
                    ? _value.teamName
                    : teamName // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as Address,
            story:
                freezed == story
                    ? _value.story
                    : story // ignore: cast_nullable_to_non_nullable
                        as String?,
            memberCount:
                null == memberCount
                    ? _value.memberCount
                    : memberCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
    _$TeamImpl value,
    $Res Function(_$TeamImpl) then,
  ) = __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int teamId,
    String teamName,
    Address address,
    String? story,
    int memberCount,
  });

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
    : super(_value, _then);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? address = null,
    Object? story = freezed,
    Object? memberCount = null,
  }) {
    return _then(
      _$TeamImpl(
        teamId:
            null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                    as int,
        teamName:
            null == teamName
                ? _value.teamName
                : teamName // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Address,
        story:
            freezed == story
                ? _value.story
                : story // ignore: cast_nullable_to_non_nullable
                    as String?,
        memberCount:
            null == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl({
    required this.teamId,
    required this.teamName,
    required this.address,
    this.story,
    required this.memberCount,
  });

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final int teamId;
  @override
  final String teamName;
  @override
  final Address address;
  @override
  final String? story;
  @override
  final int memberCount;

  @override
  String toString() {
    return 'Team(teamId: $teamId, teamName: $teamName, address: $address, story: $story, memberCount: $memberCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.story, story) || other.story == story) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, teamId, teamName, address, story, memberCount);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(this);
  }
}

abstract class _Team implements Team {
  const factory _Team({
    required final int teamId,
    required final String teamName,
    required final Address address,
    final String? story,
    required final int memberCount,
  }) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  int get teamId;
  @override
  String get teamName;
  @override
  Address get address;
  @override
  String? get story;
  @override
  int get memberCount;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
