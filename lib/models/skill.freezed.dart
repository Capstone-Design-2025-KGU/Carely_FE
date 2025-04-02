// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  SkillLevel get communication => throw _privateConstructorUsedError;
  SkillLevel get meal => throw _privateConstructorUsedError;
  SkillLevel get toilet => throw _privateConstructorUsedError;
  SkillLevel get bath => throw _privateConstructorUsedError;
  SkillLevel get walk => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({
    SkillLevel communication,
    SkillLevel meal,
    SkillLevel toilet,
    SkillLevel bath,
    SkillLevel walk,
  });
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communication = null,
    Object? meal = null,
    Object? toilet = null,
    Object? bath = null,
    Object? walk = null,
  }) {
    return _then(
      _value.copyWith(
            communication:
                null == communication
                    ? _value.communication
                    : communication // ignore: cast_nullable_to_non_nullable
                        as SkillLevel,
            meal:
                null == meal
                    ? _value.meal
                    : meal // ignore: cast_nullable_to_non_nullable
                        as SkillLevel,
            toilet:
                null == toilet
                    ? _value.toilet
                    : toilet // ignore: cast_nullable_to_non_nullable
                        as SkillLevel,
            bath:
                null == bath
                    ? _value.bath
                    : bath // ignore: cast_nullable_to_non_nullable
                        as SkillLevel,
            walk:
                null == walk
                    ? _value.walk
                    : walk // ignore: cast_nullable_to_non_nullable
                        as SkillLevel,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
    _$SkillImpl value,
    $Res Function(_$SkillImpl) then,
  ) = __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SkillLevel communication,
    SkillLevel meal,
    SkillLevel toilet,
    SkillLevel bath,
    SkillLevel walk,
  });
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
    _$SkillImpl _value,
    $Res Function(_$SkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communication = null,
    Object? meal = null,
    Object? toilet = null,
    Object? bath = null,
    Object? walk = null,
  }) {
    return _then(
      _$SkillImpl(
        communication:
            null == communication
                ? _value.communication
                : communication // ignore: cast_nullable_to_non_nullable
                    as SkillLevel,
        meal:
            null == meal
                ? _value.meal
                : meal // ignore: cast_nullable_to_non_nullable
                    as SkillLevel,
        toilet:
            null == toilet
                ? _value.toilet
                : toilet // ignore: cast_nullable_to_non_nullable
                    as SkillLevel,
        bath:
            null == bath
                ? _value.bath
                : bath // ignore: cast_nullable_to_non_nullable
                    as SkillLevel,
        walk:
            null == walk
                ? _value.walk
                : walk // ignore: cast_nullable_to_non_nullable
                    as SkillLevel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl({
    required this.communication,
    required this.meal,
    required this.toilet,
    required this.bath,
    required this.walk,
  });

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final SkillLevel communication;
  @override
  final SkillLevel meal;
  @override
  final SkillLevel toilet;
  @override
  final SkillLevel bath;
  @override
  final SkillLevel walk;

  @override
  String toString() {
    return 'Skill(communication: $communication, meal: $meal, toilet: $toilet, bath: $bath, walk: $walk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.communication, communication) ||
                other.communication == communication) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.toilet, toilet) || other.toilet == toilet) &&
            (identical(other.bath, bath) || other.bath == bath) &&
            (identical(other.walk, walk) || other.walk == walk));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, communication, meal, toilet, bath, walk);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(this);
  }
}

abstract class _Skill implements Skill {
  const factory _Skill({
    required final SkillLevel communication,
    required final SkillLevel meal,
    required final SkillLevel toilet,
    required final SkillLevel bath,
    required final SkillLevel walk,
  }) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  SkillLevel get communication;
  @override
  SkillLevel get meal;
  @override
  SkillLevel get toilet;
  @override
  SkillLevel get bath;
  @override
  SkillLevel get walk;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
